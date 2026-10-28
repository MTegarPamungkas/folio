import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/common/app_surfaces.dart';
import 'package:folio/shared/presentation/widgets/project/project_cover.dart';

class ProjectGridCard extends StatelessWidget {
  const ProjectGridCard({
    super.key,
    required this.project,
    required this.onTap,
    this.saved = false,
    this.onToggleSaved,
  });

  final Project project;
  final VoidCallback onTap;
  final bool saved;
  final VoidCallback? onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return HoverLift(
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          overlayColor: WidgetStatePropertyAll(
            colors.ink.withValues(alpha: 0.025),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colors.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: ProjectCover(
                    project: project,
                    height: 150,
                    borderRadius: 17,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 13, 18, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                project.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(fontSize: 19),
                              ),
                            ),
                            if (onToggleSaved != null)
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  tooltip: saved
                                      ? context.l10n.removeFromSaved
                                      : context.l10n.saveProject,
                                  onPressed: onToggleSaved,
                                  iconSize: 18,
                                  icon: Icon(
                                    saved
                                        ? Icons.bookmark_rounded
                                        : Icons.bookmark_border_rounded,
                                    color: saved
                                        ? colors.accent
                                        : colors.inkMuted,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          project.taglineIn(context.language),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 12,
                                height: 1.45,
                                color: colors.inkMuted,
                              ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          project.tech.take(2).join('  ·  ').toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 7.5,
                                letterSpacing: 0.7,
                                color: colors.inkMuted,
                              ),
                        ),
                        const Spacer(),
                        Container(
                          height: 1,
                          color: colors.line.withValues(alpha: 0.7),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              project.isWebsite
                                  ? Icons.language_rounded
                                  : Icons.phone_iphone_rounded,
                              size: 13,
                              color: colors.inkMuted,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                project.highlightIn(context.language),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: colors.ink,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_outward_rounded,
                                size: 16,
                                color: colors.background,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
