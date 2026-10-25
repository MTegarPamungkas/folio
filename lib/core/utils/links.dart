import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folio/shared/presentation/widgets/common/app_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalLink(
  BuildContext context,
  String url, {
  String fallbackMessage = 'Tautan belum bisa dibuka.',
}) async {
  final uri = Uri.tryParse(url);
  if (uri == null) {
    if (context.mounted) {
      showFolioSnackBar(context, message: fallbackMessage);
    }
    return;
  }

  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      showFolioSnackBar(
        context,
        message: fallbackMessage,
        actionLabel: 'Salin tautan',
        onAction: () => Clipboard.setData(ClipboardData(text: url)),
      );
    }
  } catch (_) {
    if (context.mounted) {
      showFolioSnackBar(
        context,
        message: fallbackMessage,
        actionLabel: 'Salin tautan',
        onAction: () => Clipboard.setData(ClipboardData(text: url)),
      );
    }
  }
}

Future<void> copyToClipboard(
  BuildContext context,
  String value, {
  String message = 'Disalin ke clipboard.',
}) async {
  await Clipboard.setData(ClipboardData(text: value));
  if (context.mounted) {
    showFolioSnackBar(context, message: message);
  }
}
