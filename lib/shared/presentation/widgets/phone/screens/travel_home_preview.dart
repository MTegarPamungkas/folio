import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_common.dart';

class TravelHomePreview extends StatelessWidget {
  const TravelHomePreview({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PreviewHeader(project: project),
        const SizedBox(height: 11),
        Text(
          context.l10n.whereToThisWeek,
          style: TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 18,
            height: 1,
            letterSpacing: -0.85,
            fontWeight: FontWeight.w800,
            color: p.onScreen,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 27,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(
            color: p.onScreen.withValues(alpha: 0.065),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 11, color: p.screenMuted),
              const SizedBox(width: 5),
              Text(
                context.l10n.searchDestinations,
                style: TextStyle(
                  fontFamily: FolioTypography.sans,
                  fontSize: 8,
                  color: p.screenMuted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 138,
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [p.start, p.end],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -24,
                top: -25,
                child: Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: p.ink.withValues(alpha: 0.2),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 9,
                child: Icon(
                  Icons.terrain_rounded,
                  size: 48,
                  color: p.ink.withValues(alpha: 0.28),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: p.ink.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'NEXT TRIP',
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 6,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: p.ink,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    project.previewTitleIn(context.language),
                    style: TextStyle(
                      fontFamily: FolioTypography.serifFamily,
                      fontSize: 25,
                      height: 0.95,
                      letterSpacing: -0.8,
                      fontStyle: FontStyle.italic,
                      color: p.ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 8, color: p.ink),
                      const SizedBox(width: 4),
                      Text(
                        project.previewSubtitleIn(context.language),
                        style: TextStyle(
                          fontFamily: FolioTypography.sans,
                          fontSize: 7.5,
                          fontWeight: FontWeight.w500,
                          color: p.ink.withValues(alpha: 0.84),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                'Inspirasi',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: FolioTypography.sans,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: p.onScreen,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              context.l10n.seeAll,
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 7,
                color: p.screenMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Expanded(
          child: Row(
            children: [
              for (var i = 0; i < 2; i++) ...[
                if (i > 0) const SizedBox(width: 7),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: p.onScreen.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: i == 0
                                    ? [p.start, p.end]
                                    : [p.end, p.accent],
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Icon(
                              i == 0
                                  ? Icons.waves_rounded
                                  : Icons.forest_rounded,
                              size: 20,
                              color: p.ink.withValues(alpha: 0.75),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          project.previewItemsIn(context.language)[i],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: FolioTypography.sans,
                            fontSize: 7.5,
                            fontWeight: FontWeight.w600,
                            color: p.onScreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
