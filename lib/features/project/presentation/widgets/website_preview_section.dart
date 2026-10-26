import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/core/utils/links.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/common/app_feedback.dart';
import 'package:folio/shared/presentation/widgets/website/browser_frame.dart';
import 'package:folio/shared/presentation/widgets/website/website_artwork.dart';
import 'package:folio/shared/presentation/widgets/website/website_embed.dart';

class WebsitePreviewSection extends StatefulWidget {
  const WebsitePreviewSection({
    super.key,
    required this.project,
    this.heading = 'Website live',
  });

  final Project project;
  final String heading;

  @override
  State<WebsitePreviewSection> createState() => _WebsitePreviewSectionState();
}

class _WebsitePreviewSectionState extends State<WebsitePreviewSection> {
  int _reloadToken = 0;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final colors = context.folio;
    final theme = Theme.of(context);
    final palette = project.palette;
    final resolvedUri = _resolveLiveUri(project.liveUrl);
    final canOpenDirectly = resolvedUri != null;
    final height = context.isCompact ? 370.0 : 540.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      decoration: BoxDecoration(
        color: colors.surfaceMuted.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdaptiveTwoPane(
            breakpoint: 700,
            gap: 14,
            compactGap: 12,
            start: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.heading,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 21,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: palette.start.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: palette.start,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'LIVE',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.ink,
                              fontSize: 7.5,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  kIsWeb
                      ? 'Jelajahi situsnya langsung di sini, atau buka di tab baru.'
                      : 'Pratinjau statis tersedia di sini; buka situs untuk pengalaman penuh.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: colors.inkMuted,
                  ),
                ),
              ],
            ),
            end: Wrap(
              spacing: 7,
              runSpacing: 7,
              alignment: WrapAlignment.end,
              children: [
                if (kIsWeb)
                  OutlinedButton.icon(
                    onPressed: () => setState(() => _reloadToken += 1),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 42),
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Muat ulang'),
                  ),
                FilledButton.icon(
                  onPressed: canOpenDirectly
                      ? () => openExternalLink(
                          context,
                          resolvedUri.toString(),
                          fallbackMessage:
                              'Situs belum bisa dibuka dari preview.',
                        )
                      : () => _showDirectFallback(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.ink,
                    foregroundColor: colors.background,
                    minimumSize: const Size(0, 42),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  icon: const Icon(Icons.arrow_outward_rounded, size: 16),
                  label: const Text('Buka langsung'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          BrowserFrame(
            height: height,
            address: _addressLabel(project.liveUrl),
            onOpen: () => canOpenDirectly
                ? openExternalLink(
                    context,
                    resolvedUri.toString(),
                    fallbackMessage: 'Situs belum bisa dibuka dari preview.',
                  )
                : _showDirectFallback(context),
            onReload: kIsWeb ? () => setState(() => _reloadToken += 1) : null,
            child: resolvedUri == null
                ? WebsiteArtwork(project: project)
                : WebsiteEmbed(
                    key: ValueKey('${resolvedUri}_$_reloadToken'),
                    url: resolvedUri.toString(),
                    fallback: WebsiteArtwork(project: project),
                  ),
          ),
          const SizedBox(height: 11),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.open_in_new_rounded, size: 12, color: colors.inkMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  canOpenDirectly
                      ? 'Kamu bisa memilih untuk tetap di halaman ini atau membuka situs langsung di tab baru.'
                      : 'Live site demo ini memakai tautan relatif dan tersedia saat aplikasi dijalankan sebagai website. Untuk versi native, ganti liveUrl dengan URL publik.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    height: 1.5,
                    color: colors.inkMuted,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDirectFallback(BuildContext context) {
    showFolioSnackBar(
      context,
      message:
          'Live site demo ini tersedia di versi web. '
          'Kamu tetap bisa membuka preview statis di halaman ini.',
      actionLabel: 'Salin tautan',
      onAction: () =>
          Clipboard.setData(ClipboardData(text: widget.project.liveUrl ?? '')),
    );
  }

  Uri? _resolveLiveUri(String? rawUrl) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return null;
    final parsed = Uri.tryParse(rawUrl.trim());
    if (parsed == null) return null;
    if (parsed.hasScheme) return parsed;
    if (!kIsWeb) return null;
    return Uri.base.resolve(rawUrl);
  }

  String _addressLabel(String? rawUrl) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return 'Belum ada live site';
    final parsed = Uri.tryParse(rawUrl.trim());
    if (parsed != null && parsed.hasScheme && parsed.host.isNotEmpty) {
      return parsed.host;
    }
    return rawUrl.replaceFirst(RegExp(r'^\.?\/'), '');
  }
}
