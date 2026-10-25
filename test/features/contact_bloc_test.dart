import 'package:flutter_test/flutter_test.dart';
import 'package:folio/data/datasources/portfolio_json_data_source.dart';
import 'package:folio/data/repositories/portfolio_repository_impl.dart';
import 'package:folio/domain/entities/contact_request.dart';
import 'package:folio/domain/repositories/contact_repository.dart';
import 'package:folio/domain/usecases/get_contact_context.dart';
import 'package:folio/domain/usecases/send_contact_request.dart';
import 'package:folio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:folio/features/contact/presentation/bloc/contact_event.dart';
import 'package:folio/features/contact/presentation/bloc/contact_state.dart';

class _FakeContactRepository implements ContactRepository {
  ContactRequest? lastRequest;
  String? lastRecipient;
  String? lastProjectName;
  bool result = true;

  @override
  Future<bool> send({
    required String recipient,
    required ContactRequest request,
    String? projectName,
  }) async {
    lastRecipient = recipient;
    lastRequest = request;
    lastProjectName = projectName;
    return result;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PortfolioRepositoryImpl portfolio;

  setUpAll(() async {
    final content = await PortfolioJsonDataSource().load();
    portfolio = PortfolioRepositoryImpl(content);
  });

  ContactBloc buildBloc(
    _FakeContactRepository repository, {
    String? projectId,
  }) {
    return ContactBloc(
      GetContactContext(portfolio),
      SendContactRequest(repository),
      projectId,
    );
  }

  test('prefills the message with the selected project', () {
    final bloc = buildBloc(_FakeContactRepository(), projectId: 'mis-msa');
    expect(bloc.state.projectName, 'MIS MSA');
    expect(bloc.state.message, contains('proyek MIS MSA'));
    expect(bloc.state.context.developer.email, isNotEmpty);
  });

  test('validates required form fields before sending', () async {
    final repository = _FakeContactRepository();
    final bloc = buildBloc(repository);
    final validation = bloc.stream.firstWhere((state) => state.hasErrors);
    bloc.add(const ContactSubmitted());
    await validation;

    expect(bloc.state.nameError, isNotNull);
    expect(bloc.state.emailError, isNotNull);
    expect(bloc.state.messageError, isNotNull);
    expect(repository.lastRequest, isNull);
  });

  test('sends a valid request and exposes success', () async {
    final repository = _FakeContactRepository();
    final bloc = buildBloc(repository, projectId: 'mis-msa');
    bloc
      ..add(const ContactNameChanged('Tegar'))
      ..add(const ContactEmailChanged('tegar@example.com'))
      ..add(
        const ContactMessageChanged(
          'Saya ingin membangun aplikasi yang rapi dan cepat.',
        ),
      );

    final success = bloc.stream.firstWhere(
      (state) => state.status == ContactStatus.success,
    );
    bloc.add(const ContactSubmitted());
    await success;

    expect(repository.lastRecipient, 'mtegarpamungkas111@gmail.com');
    expect(repository.lastProjectName, 'MIS MSA');
    expect(repository.lastRequest?.email, 'tegar@example.com');
  });

  test('surfaces a failure when the email client cannot open', () async {
    final repository = _FakeContactRepository()..result = false;
    final bloc = buildBloc(repository);
    bloc
      ..add(const ContactNameChanged('Tegar'))
      ..add(const ContactEmailChanged('tegar@example.com'))
      ..add(
        const ContactMessageChanged(
          'Saya ingin membangun aplikasi yang rapi dan cepat.',
        ),
      );

    final failure = bloc.stream.firstWhere(
      (state) => state.status == ContactStatus.failure,
    );
    bloc.add(const ContactSubmitted());
    await failure;

    expect(bloc.state.errorMessage, isNotNull);
  });
}
