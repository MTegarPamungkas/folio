import 'package:folio/domain/entities/contact_request.dart';

abstract interface class ContactRepository {
  Future<bool> send({
    required String recipient,
    required ContactRequest request,
    String? projectName,
  });
}
