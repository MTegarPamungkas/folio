import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/widgets/website/browser_frame.dart';

/// Real page captures of a website project, laid out as a horizontal slider of
/// browser frames—the website counterpart of the phone screenshot gallery.
class WebsiteScreensGallery extends StatelessWidget {
  const WebsiteScreensGallery({
    super.key,
    required this.project,
    this.cardWidth = 360,
  });

  final Project project;
  final double cardWidth;

  static const double _gap = 18;

  /// Captures are taken at 1200×817; the frame keeps that ratio so nothing is
  /// cropped except the browser chrome replaced by [BrowserFrame].
  static const double _captureAspect = 1200 / 817;
  static const double _chromeHeight = 30;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final screenshots = project.screenshots;
    final address = _address(project.liveUrl);
    final captionStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
      fontSize: 9.5,
      letterSpacing: 0.9,
      color: colors.inkMuted,
    );

    Widget card(ProjectScreenshot shot) {
      return SizedBox(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: cardWidth / _captureAspect + _chromeHeight,
              child: BrowserFrame(
                compact: true,
                address: address,
                child: Image.asset(
                  shot.asset,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  filterQuality: FilterQuality.medium,
                  gaplessPlayback: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              shot.labelIn(context.language),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: captionStyle,
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth =
            cardWidth * screenshots.length + _gap * (screenshots.length - 1);
        final fits = totalWidth <= constraints.maxWidth;

        final row = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < screenshots.length; i++) ...[
              if (i > 0) const SizedBox(width: _gap),
              card(screenshots[i]),
            ],
          ],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fits)
              Center(child: row)
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: const EdgeInsets.only(bottom: 4),
                child: row,
              ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  fits ? Icons.web_asset_rounded : Icons.swipe_rounded,
                  size: 13,
                  color: colors.inkMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    fits
                        ? context.trArgs(
                            '{count} halaman asli dari situs live.',
                            {'count': '${screenshots.length}'},
                          )
                        : context.trArgs(
                            '{count} halaman asli—geser untuk lihat semua.',
                            {'count': '${screenshots.length}'},
                          ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: colors.inkMuted,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _address(String? rawUrl) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return project.name;
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri != null && uri.host.isNotEmpty) return uri.host;
    return rawUrl.replaceFirst(RegExp(r'^https?:\/\/'), '');
  }
}
