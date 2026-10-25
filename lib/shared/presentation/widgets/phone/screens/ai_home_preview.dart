import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_common.dart';

class AiHomePreview extends StatelessWidget {
  const AiHomePreview({super.key, required this.project});

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
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 11,
              color: p.onScreen,
            ),
          ),
        ),
        const SizedBox(height: 11),
        Text(
          'Temukan palet\ndari sebuah momen.',
          style: TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 16,
            height: 1.06,
            letterSpacing: -0.7,
            fontWeight: FontWeight.w800,
            color: p.onScreen,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          height: 145,
          width: double.infinity,
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
                right: 15,
                top: 17,
                child: Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.accent.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                bottom: 22,
                child: Transform.rotate(
                  angle: -0.28,
                  child: Container(
                    width: 82,
                    height: 100,
                    decoration: BoxDecoration(
                      color: p.ink.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: p.ink.withValues(alpha: 0.24)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: p.ink.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'KROMA AI',
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
                      project.previewTitle,
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                      ),
                    ),
                    Text(
                      project.previewSubtitle,
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7,
                        color: p.ink.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Text(
              'Palet',
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: p.onScreen,
              ),
            ),
            const Spacer(),
            Text(
              'Simpan',
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 7,
                color: p.screenMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            for (final color in [
              p.start,
              p.end,
              p.accent,
              const Color(0xFFF2A65A),
              const Color(0xFF6E4B7A),
            ]) ...[
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.auto_awesome_rounded, size: 9, color: p.accent),
            const SizedBox(width: 4),
            Text(
              project.previewMetric,
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 7.5,
                fontWeight: FontWeight.w700,
                color: p.onScreen,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              project.previewMetricLabel,
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 7.5,
                color: p.screenMuted,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
