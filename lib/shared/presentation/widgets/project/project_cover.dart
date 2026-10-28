import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/brand/category_pill.dart';
import 'package:folio/shared/presentation/widgets/project/project_icon.dart';
import 'package:folio/shared/presentation/widgets/project/project_pattern_painter.dart';

class ProjectCover extends StatelessWidget {
  const ProjectCover({
    super.key,
    required this.project,
    this.height = 168,
    this.borderRadius = 20,
    this.showMeta = true,
    this.showIcon = true,
  });

  final Project project;
  final double height;
  final double borderRadius;
  final bool showMeta;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return RepaintBoundary(
      child: SizedBox(
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [p.start, p.end],
                  ),
                ),
              ),
              CustomPaint(
                painter: ProjectPatternPainter(
                  category: project.category,
                  color: p.ink,
                  accent: p.accent,
                ),
              ),
              Positioned(
                right: -height * 0.12,
                bottom: -height * 0.46,
                child: ExcludeSemantics(
                  child: Text(
                    project.name.substring(0, 1),
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: height * 1.13,
                      height: 0.8,
                      letterSpacing: -8,
                      fontWeight: FontWeight.w800,
                      color: p.ink.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              ),
              if (showMeta)
                Positioned(
                  top: 13,
                  left: 13,
                  right: 13,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryPill(
                        category: project.category,
                        onDark: true,
                        color: p.ink,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: p.ink.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: p.ink.withValues(alpha: 0.18),
                          ),
                        ),
                        child: Text(
                          project.year,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: p.ink,
                                fontSize: 9,
                                letterSpacing: 0.7,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (showIcon)
                Positioned(
                  left: 16,
                  bottom: 15,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          color: p.ink.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ProjectIcon(project: project, size: 48),
                      ),
                      const SizedBox(width: 11),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            project.name,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: p.ink,
                                  fontSize: 20,
                                  letterSpacing: -0.6,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            project
                                .previewMetricLabelIn(context.language)
                                .toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: p.ink.withValues(alpha: 0.7),
                                  fontSize: 8,
                                  letterSpacing: 0.85,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: p.ink.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: p.ink.withValues(alpha: 0.16)),
                  ),
                  child: Text(
                    project.previewMetricIn(context.language),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: p.ink,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
