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

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final totalWidth = phoneWidth * 3 + 40;

    return LayoutBuilder(
      builder: (context, constraints) {
        final fits = totalWidth <= constraints.maxWidth;
        final screens = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) const SizedBox(width: 20),
              Column(
                children: [
                  PhoneMockup(project: project, variant: i, width: phoneWidth),
                  const SizedBox(height: 11),
                  Text(
                    const ['Utama', 'Detail', 'Ringkasan'][i],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 9.5,
                      letterSpacing: 0.9,
                      color: colors.inkMuted,
                    ),
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
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  fits ? Icons.grid_view_rounded : Icons.swipe_rounded,
                  size: 13,
                  color: colors.inkMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    fits
                        ? 'Tiga layar utama, dari alur sampai ringkasan.'
                        : 'Geser untuk melihat pratinjau',
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
