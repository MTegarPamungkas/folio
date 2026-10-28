import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_common.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_painters.dart';

class ProjectSummaryPreview extends StatelessWidget {
  const ProjectSummaryPreview({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Ringkasan',
                style: TextStyle(
                  fontFamily: FolioTypography.sans,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: p.onScreen,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.calendar_today_rounded,
                size: 12,
                color: p.screenMuted,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            project.previewMetricLabelIn(context.language).toUpperCase(),
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 6.5,
              letterSpacing: 0.9,
              fontWeight: FontWeight.w700,
              color: p.screenMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            project.previewMetricIn(context.language),
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 32,
              height: 1,
              letterSpacing: -1.6,
              fontWeight: FontWeight.w800,
              color: p.onScreen,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.trending_up_rounded, size: 10, color: p.start),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '+18,2% dibanding pekan lalu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FolioTypography.sans,
                    fontSize: 7,
                    color: p.screenMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Container(
            height: 78,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: p.onScreen.withValues(alpha: 0.045),
              borderRadius: BorderRadius.circular(11),
            ),
            child: CustomPaint(
              painter: PreviewBarChartPainter(
                color: p.start,
                muted: p.onScreen.withValues(alpha: 0.08),
              ),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: PreviewMiniStat(
                  project: project,
                  label: context.l10n.session,
                  value: '24',
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: PreviewMiniStat(
                  project: project,
                  label: context.l10n.time,
                  value: '6j 40m',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.activity,
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: p.onScreen,
            ),
          ),
          const SizedBox(height: 6),
          for (final item in project.previewItemsIn(context.language)) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              decoration: BoxDecoration(
                color: p.onScreen.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: p.start.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(project.icon, size: 10, color: p.start),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7.5,
                        fontWeight: FontWeight.w500,
                        color: p.onScreen,
                      ),
                    ),
                  ),
                  Text(
                    '08.40',
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: 6.5,
                      color: p.screenMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
          const Spacer(),
        ],
      ),
    );
  }
}
