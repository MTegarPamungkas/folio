import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/entities/contact_context.dart';
import 'package:folio/domain/entities/contact_request.dart';
import 'package:folio/domain/usecases/get_contact_context.dart';
import 'package:folio/domain/usecases/send_contact_request.dart';
import 'package:folio/features/contact/presentation/bloc/contact_event.dart';
import 'package:folio/features/contact/presentation/bloc/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  factory ContactBloc(
    GetContactContext getContactContext,
    SendContactRequest sendContactRequest,
    String? projectId,
  ) {
    final context = getContactContext(projectId);
    return ContactBloc._(context, sendContactRequest);
  }

  ContactBloc._(ContactContext context, this._sendContactRequest)
    : super(
        ContactState(
          context: context,
          name: '',
          email: '',
          projectType: contactProjectTypes.first,
          message: _initialMessage(context),
        ),
      ) {
    on<ContactNameChanged>(_onNameChanged);
    on<ContactEmailChanged>(_onEmailChanged);
    on<ContactProjectTypeChanged>(_onProjectTypeChanged);
    on<ContactMessageChanged>(_onMessageChanged);
    on<ContactSubmitted>(_onSubmitted);
    on<ContactStatusAcknowledged>(_onStatusAcknowledged);
  }

  final SendContactRequest _sendContactRequest;

  static String _initialMessage(ContactContext context) {
    final project = context.project;
    if (project == null) return '';
    return 'Halo ${context.developer.shortName}, saya tertarik dengan proyek '
        '${project.name}. Saya ingin membahas ide yang mirip dan bertanya '
        'tentang prosesnya.';
  }

  void _onNameChanged(ContactNameChanged event, Emitter<ContactState> emit) {
    emit(
      state.copyWith(
        name: event.value,
        clearNameError: true,
        status: ContactStatus.idle,
      ),
    );
  }

  void _onEmailChanged(ContactEmailChanged event, Emitter<ContactState> emit) {
    emit(
      state.copyWith(
        email: event.value,
        clearEmailError: true,
        status: ContactStatus.idle,
      ),
    );
  }

  void _onProjectTypeChanged(
    ContactProjectTypeChanged event,
    Emitter<ContactState> emit,
  ) {
    emit(state.copyWith(projectType: event.value, status: ContactStatus.idle));
  }

  void _onMessageChanged(
    ContactMessageChanged event,
    Emitter<ContactState> emit,
  ) {
    emit(
      state.copyWith(
        message: event.value,
        clearMessageError: true,
        status: ContactStatus.idle,
      ),
    );
  }

  Future<void> _onSubmitted(
    ContactSubmitted event,
    Emitter<ContactState> emit,
  ) async {
    final nameError = state.name.trim().length < 2 ? 'Nama perlu diisi.' : null;
    final email = state.email.trim();
    final emailError = !_emailPattern.hasMatch(email)
        ? 'Format email belum benar.'
        : null;
    final messageError = state.message.trim().length < 20
        ? 'Ceritakan sedikit lebih banyak (minimal 20 karakter).'
        : null;

    if (nameError != null || emailError != null || messageError != null) {
      emit(
        state.copyWith(
          status: ContactStatus.idle,
          nameError: nameError,
          emailError: emailError,
          messageError: messageError,
          clearNameError: nameError == null,
          clearEmailError: emailError == null,
          clearMessageError: messageError == null,
          clearErrorMessage: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ContactStatus.submitting,
        clearNameError: true,
        clearEmailError: true,
        clearMessageError: true,
        clearErrorMessage: true,
      ),
    );

    try {
      final opened = await _sendContactRequest(
        recipient: state.context.developer.email,
        request: ContactRequest(
          name: state.name.trim(),
          email: email,
          projectType: state.projectType,
          message: state.message.trim(),
        ),
        projectName: state.context.project?.name,
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          status: opened ? ContactStatus.success : ContactStatus.failure,
          errorMessage: opened
              ? null
              : 'Aplikasi email tidak tersedia di perangkat ini.',
          clearErrorMessage: opened,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ContactStatus.failure,
          errorMessage: 'Aplikasi email tidak tersedia di perangkat ini.',
        ),
      );
    }
  }

  void _onStatusAcknowledged(
    ContactStatusAcknowledged event,
    Emitter<ContactState> emit,
  ) {
    if (state.status == ContactStatus.idle || state.isSubmitting) return;
    emit(state.copyWith(status: ContactStatus.idle, clearErrorMessage: true));
  }

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
}
