import 'dart:math' as math;

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

    Widget screen(int index, double width) {
      return Column(
        children: [
          PhoneMockup(project: project, variant: index, width: width),
          const SizedBox(height: 11),
          Text(
            project.screenshotAt(index)?.label ??
                const ['Utama', 'Detail', 'Ringkasan'][index],
            style: captionStyle,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Real captures are shown as a grid so every screenshot is visible at
        // once; generated previews stay in a single scrollable row.
        final grid = project.hasScreenshots;
        const minItemWidth = 158.0;
        final maxWidth = constraints.maxWidth;
        var columns = count;
        var itemWidth = phoneWidth;
        if (grid) {
          final natural = ((maxWidth + _gap) / (phoneWidth + _gap)).floor();
          columns = math.min(count, math.max(2, natural));
          itemWidth = (maxWidth - _gap * (columns - 1)) / columns;
          if (itemWidth < minItemWidth) {
            columns = math.max(1, columns - 1);
            itemWidth = (maxWidth - _gap * (columns - 1)) / columns;
          }
          itemWidth = math.min(itemWidth, phoneWidth);
        }
        final fits = itemWidth * columns + _gap * (columns - 1) <= maxWidth;

        final screens = grid
            ? Wrap(
                spacing: _gap,
                runSpacing: 22,
                alignment: WrapAlignment.center,
                children: [
                  for (var i = 0; i < count; i++)
                    SizedBox(width: itemWidth, child: screen(i, itemWidth)),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < count; i++) ...[
                    if (i > 0) const SizedBox(width: _gap),
                    screen(i, itemWidth),
                  ],
                ],
              );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fits || grid)
              screens
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
                  grid ? Icons.photo_library_outlined : Icons.swipe_rounded,
                  size: 13,
                  color: colors.inkMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    grid
                        ? '$count tangkapan layar asli dari aplikasi.'
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
