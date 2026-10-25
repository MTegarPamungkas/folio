import 'package:folio/domain/entities/contact_request.dart';
import 'package:folio/domain/repositories/contact_repository.dart';

class SendContactRequest {
  const SendContactRequest(this._repository);

  final ContactRepository _repository;

  Future<bool> call({
    required String recipient,
    required ContactRequest request,
    String? projectName,
  }) {
    return _repository.send(
      recipient: recipient,
      request: request,
      projectName: projectName,
    );
  }
}
