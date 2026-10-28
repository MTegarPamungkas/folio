import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/core/localization/entity_labels.dart';
import 'package:folio/shared/presentation/widgets/project/project_icon.dart';

class ProjectListTile extends StatelessWidget {
  const ProjectListTile({
    super.key,
    required this.project,
    required this.onTap,
    this.showArrow = true,
  });

  final Project project;
  final VoidCallback onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        overlayColor: WidgetStatePropertyAll(
          colors.ink.withValues(alpha: 0.03),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.line),
          ),
          child: Row(
            children: [
              ProjectIcon(project: project, size: 58),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            project.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          projectTypeLabel(context.l10n, project.type),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 8,
                                letterSpacing: 0.5,
                                color: colors.inkMuted,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.taglineIn(context.language),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: colors.inkMuted,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${projectCategoryLabel(context.l10n, project.category)} · '
                      '${project.version}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        letterSpacing: 0.45,
                        color: colors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (showArrow) ...[
                const SizedBox(width: 10),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: colors.surfaceMuted,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: colors.ink,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
