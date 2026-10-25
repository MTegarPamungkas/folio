import 'package:folio/domain/entities/contact_request.dart';
import 'package:folio/domain/repositories/contact_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRepositoryImpl implements ContactRepository {
  const ContactRepositoryImpl();

  @override
  Future<bool> send({
    required String recipient,
    required ContactRequest request,
    String? projectName,
  }) {
    final subject = '[Folio] ${request.projectType} — ${request.name}';
    final projectContext = projectName == null
        ? ''
        : '\nProyek yang dibahas: $projectName';
    final body =
        'Halo,\n\n'
        '${request.message}\n'
        '$projectContext\n'
        'Jenis proyek: ${request.projectType}\n'
        'Nama: ${request.name}\n'
        'Email: ${request.email}\n\n'
        'Dikirim dari Folio.';

    final uri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {'subject': subject, 'body': body},
    );

    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
