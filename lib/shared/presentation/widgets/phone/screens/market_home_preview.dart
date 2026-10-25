import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_common.dart';

class MarketHomePreview extends StatelessWidget {
  const MarketHomePreview({super.key, required this.project});

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
              color: p.accent.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shopping_bag_rounded, size: 11, color: p.accent),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 26,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: p.onScreen.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, size: 10, color: p.screenMuted),
                    const SizedBox(width: 5),
                    Text(
                      'Cari karya lokal',
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7.5,
                        color: p.screenMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: p.accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.tune_rounded, size: 12, color: p.start),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 118,
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [p.end, p.start],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: p.accent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'PILIHAN KURATOR',
                        style: TextStyle(
                          fontFamily: FolioTypography.sans,
                          fontSize: 5.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: p.start,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      project.previewTitle,
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 18,
                        height: 1,
                        letterSpacing: -0.6,
                        fontWeight: FontWeight.w800,
                        color: p.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      project.previewSubtitle,
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7,
                        color: p.ink.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 80,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: p.ink.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.chair_alt_rounded,
                  size: 38,
                  color: p.ink.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 11),
        Row(
          children: [
            Text(
              'Baru dari pengrajin',
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: p.onScreen,
              ),
            ),
            const Spacer(),
            Text(
              'Lihat',
              style: TextStyle(
                fontFamily: FolioTypography.sans,
                fontSize: 7,
                color: p.screenMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Expanded(
          child: Row(
            children: [
              for (var i = 0; i < 2; i++) ...[
                if (i > 0) const SizedBox(width: 7),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: p.onScreen.withValues(alpha: 0.055),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: p.accent.withValues(
                                alpha: i == 0 ? 0.8 : 0.32,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Icon(
                              i == 0
                                  ? Icons.light_rounded
                                  : Icons.local_florist_rounded,
                              size: 23,
                              color: p.start,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          project.previewItems[i],
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
