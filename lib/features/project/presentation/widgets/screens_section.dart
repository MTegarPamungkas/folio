import 'package:flutter/material.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/widgets/phone/project_screens_gallery.dart';

class ScreensSection extends StatelessWidget {
  const ScreensSection({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    final phoneWidth = context.responsive<double>(
      compact: 194,
      medium: 214,
      expanded: 214,
    );

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('Tampilan aplikasi'),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 21,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      project.hasScreenshots
                          ? context.tr(
                              'Tangkapan layar asli, dari alur utama sampai fiturnya.',
                            )
                          : context.tr(
                              'Tiga layar yang menunjukkan arah visual dan alur utama.',
                            ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: colors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: colors.line),
                ),
                child: Text(
                  project.hasScreenshots
                      ? context.trArgs('{count} TANGKAPAN', {
                          'count': '${project.screenshots.length}',
                        })
                      : context.tr('3 LAYAR'),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 8,
                    letterSpacing: 0.6,
                    color: colors.inkMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ProjectScreensGallery(project: project, phoneWidth: phoneWidth),
        ],
      ),
    );
  }
}
