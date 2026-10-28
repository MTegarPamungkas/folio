import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/widgets/common/app_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalLink(
  BuildContext context,
  String url, {
  String? fallbackMessage,
}) async {
  final message =
      fallbackMessage ?? context.readTr('Tautannya belum bisa dibuka.');
  final copyLabel = context.readTr('Salin tautan');
  final uri = Uri.tryParse(url);
  if (uri == null) {
    if (context.mounted) {
      showFolioSnackBar(context, message: message);
    }
    return;
  }

  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      showFolioSnackBar(
        context,
        message: message,
        actionLabel: copyLabel,
        onAction: () => Clipboard.setData(ClipboardData(text: url)),
      );
    }
  } catch (_) {
    if (context.mounted) {
      showFolioSnackBar(
        context,
        message: message,
        actionLabel: copyLabel,
        onAction: () => Clipboard.setData(ClipboardData(text: url)),
      );
    }
  }
}

Future<void> copyToClipboard(
  BuildContext context,
  String value, {
  String? message,
}) async {
  final text = message ?? context.readTr('Sudah disalin.');
  await Clipboard.setData(ClipboardData(text: value));
  if (context.mounted) {
    showFolioSnackBar(context, message: text);
  }
}
