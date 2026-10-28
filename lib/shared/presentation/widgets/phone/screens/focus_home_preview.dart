import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_common.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_painters.dart';

class FocusHomePreview extends StatelessWidget {
  const FocusHomePreview({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PreviewHeader(
          project: project,
          trailing: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: p.onScreen.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.more_horiz_rounded, size: 12, color: p.onScreen),
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: Text(
            'SESI FOKUS',
            style: TextStyle(
              fontFamily: FolioTypography.sans,
              fontSize: 7,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.screenMuted,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Center(
          child: SizedBox(
            width: 146,
            height: 146,
            child: CustomPaint(
              painter: PreviewTimerPainter(
                track: p.onScreen.withValues(alpha: 0.08),
                progress: p.start,
                accent: p.accent,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      project.previewMetricIn(context.language),
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 27,
                        height: 1,
                        letterSpacing: -1.4,
                        fontWeight: FontWeight.w700,
                        color: p.onScreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.previewMetricLabelIn(context.language),
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7,
                        color: p.screenMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 9),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            decoration: BoxDecoration(
              color: p.start,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              'Jeda sejenak',
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: p.ink,
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: p.onScreen.withValues(alpha: 0.045),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: p.start.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.self_improvement_rounded,
                  size: 15,
                  color: p.start,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.previewItemsIn(context.language)[0],
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: p.onScreen,
                      ),
                    ),
                    Text(
                      project.previewItemsIn(context.language)[1],
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7,
                        color: p.screenMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_rounded, size: 12, color: p.onScreen),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
