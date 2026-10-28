import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_common.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_painters.dart';

class FinanceHomePreview extends StatelessWidget {
  const FinanceHomePreview({super.key, required this.project});

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
              color: p.accent.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_rounded, size: 11, color: p.accent),
          ),
        ),
        const SizedBox(height: 13),
        Text(
          context.tr('Sisa bulan ini'),
          style: TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 8,
            color: p.screenMuted,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          project.previewTitleIn(context.language),
          style: TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 24,
            height: 1,
            letterSpacing: -1,
            fontWeight: FontWeight.w700,
            color: p.onScreen,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: p.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                context.tr('+12,4% dari bulan lalu'),
                style: TextStyle(
                  fontFamily: FolioTypography.sans,
                  fontSize: 6.5,
                  fontWeight: FontWeight.w600,
                  color: p.accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 116,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(11, 10, 11, 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                p.onScreen.withValues(alpha: 0.09),
                p.onScreen.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: p.onScreen.withValues(alpha: 0.07)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Arus kas',
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: p.onScreen,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '6 bulan',
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: 7,
                      color: p.screenMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CustomPaint(
                  painter: PreviewLineChartPainter(
                    color: p.accent,
                    gridColor: p.onScreen.withValues(alpha: 0.06),
                  ),
                  size: Size.infinite,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Terbaru',
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: p.onScreen,
              ),
            ),
            const Spacer(),
            Text(
              context.tr('Semua'),
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 7,
                color: p.screenMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        for (var i = 0; i < 2; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            decoration: BoxDecoration(
              color: p.onScreen.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: p.onScreen.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Icon(
                    i == 0
                        ? Icons.restaurant_rounded
                        : Icons.directions_car_filled_rounded,
                    size: 11,
                    color: p.accent,
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    project.previewItemsIn(context.language)[i],
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: p.onScreen,
                    ),
                  ),
                ),
                Text(
                  i == 0 ? '-Rp 420 rb' : '-Rp 180 rb',
                  style: TextStyle(
                    fontFamily: FolioTypography.sans,
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    color: p.screenMuted,
                  ),
                ),
              ],
            ),
          ),
          if (i == 0) const SizedBox(height: 5),
        ],
        const Spacer(),
      ],
    );
  }
}
