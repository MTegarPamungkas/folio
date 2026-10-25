import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';

/// A static, designed website preview used when an iframe is not available.
///
/// It intentionally mirrors the live microsite's visual language.
class WebsiteArtwork extends StatelessWidget {
  const WebsiteArtwork({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    final title = project.editorialTitle.replaceAll('\n', ' ');

    return ExcludeSemantics(
      child: FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 720,
          height: 460,
          child: ColoredBox(
            color: p.screen,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(34, 24, 34, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ArtworkNav(project: project),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'FIELD OPERATIONS · ${project.year}',
                                style: TextStyle(
                                  fontFamily: FolioTypography.sans,
                                  fontSize: 8,
                                  letterSpacing: 1.6,
                                  fontWeight: FontWeight.w700,
                                  color: p.screenMuted,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: FolioTypography.sans,
                                  fontSize: 36,
                                  height: 0.98,
                                  letterSpacing: -1.7,
                                  fontWeight: FontWeight.w800,
                                  color: p.onScreen,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 260,
                                ),
                                child: Text(
                                  project.tagline,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: FolioTypography.sans,
                                    fontSize: 9,
                                    height: 1.55,
                                    color: p.screenMuted,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: p.onScreen,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  'Buka console',
                                  style: TextStyle(
                                    fontFamily: FolioTypography.sans,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: p.screen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [p.start, p.end],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: -34,
                                  top: -34,
                                  child: Container(
                                    width: 170,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: p.ink.withValues(alpha: 0.25),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  bottom: 20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project.previewMetric,
                                        style: TextStyle(
                                          fontFamily: FolioTypography.sans,
                                          fontSize: 38,
                                          height: 0.9,
                                          letterSpacing: -2,
                                          fontWeight: FontWeight.w800,
                                          color: p.ink,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        project.previewMetricLabel,
                                        style: TextStyle(
                                          fontFamily: FolioTypography.sans,
                                          fontSize: 8,
                                          color: p.ink.withValues(alpha: 0.75),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      for (var i = 0; i < project.previewItems.length; i++) ...[
                        if (i > 0) const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: p.onScreen.withValues(alpha: 0.13),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '0${i + 1}',
                                  style: TextStyle(
                                    fontFamily: FolioTypography.sans,
                                    fontSize: 7,
                                    fontWeight: FontWeight.w700,
                                    color: p.screenMuted,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    project.previewItems[i],
                                    style: TextStyle(
                                      fontFamily: FolioTypography.sans,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: p.onScreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArtworkNav extends StatelessWidget {
  const _ArtworkNav({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Row(
      children: [
        Text(
          project.name.toLowerCase(),
          style: TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
            color: p.onScreen,
          ),
        ),
        const Spacer(),
        for (final label in ['Overview', 'Attendance', 'Reports']) ...[
          Text(
            label,
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 8,
              color: p.screenMuted,
            ),
          ),
          const SizedBox(width: 18),
        ],
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            border: Border.all(color: p.onScreen.withValues(alpha: 0.25)),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.arrow_outward_rounded, size: 11, color: p.onScreen),
        ),
      ],
    );
  }
}
