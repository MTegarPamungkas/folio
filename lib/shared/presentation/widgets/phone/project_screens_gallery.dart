import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/widgets/phone/phone_mockup.dart';

class ProjectScreensGallery extends StatelessWidget {
  const ProjectScreensGallery({
    super.key,
    required this.project,
    this.phoneWidth = 214,
  });

  final Project project;
  final double phoneWidth;

  static const double _gap = 20;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final count = project.hasScreenshots ? project.screenshots.length : 3;
    final captionStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
      fontSize: 9.5,
      letterSpacing: 0.9,
      color: colors.inkMuted,
    );
    final totalWidth = phoneWidth * count + _gap * (count - 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final fits = totalWidth <= constraints.maxWidth;

        final screens = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < count; i++) ...[
              if (i > 0) const SizedBox(width: _gap),
              Column(
                children: [
                  PhoneMockup(project: project, variant: i, width: phoneWidth),
                  const SizedBox(height: 11),
                  Text(
                    project.screenshotAt(i)?.label ??
                        const ['Utama', 'Detail', 'Ringkasan'][i],
                    style: captionStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fits)
              Center(child: screens)
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: const EdgeInsets.only(bottom: 4),
                child: screens,
              ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  fits
                      ? (project.hasScreenshots
                            ? Icons.photo_library_outlined
                            : Icons.grid_view_rounded)
                      : Icons.swipe_rounded,
                  size: 13,
                  color: colors.inkMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    project.hasScreenshots
                        ? (fits
                              ? '$count tangkapan layar asli dari aplikasi.'
                              : '$count tangkapan layar asli—geser untuk lihat semua.')
                        : (fits
                              ? 'Tiga layar utama, dari alur sampai ringkasan.'
                              : 'Geser untuk melihat pratinjau'),
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
}
