import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/phone/preview_common.dart';

class FoodHomePreview extends StatelessWidget {
  const FoodHomePreview({super.key, required this.project});

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
            child: Icon(
              Icons.bookmark_border_rounded,
              size: 11,
              color: p.onScreen,
            ),
          ),
        ),
        const SizedBox(height: 11),
        Text(
          'Masak sesuatu\nyang mengingatkan.',
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
          height: 136,
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
                right: 14,
                top: 14,
                child: Icon(
                  Icons.ramen_dining_rounded,
                  size: 84,
                  color: p.ink.withValues(alpha: 0.25),
                ),
              ),
              Positioned(
                right: 86,
                bottom: 44,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.accent.withValues(alpha: 0.35),
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
                        'RESEP KELUARGA',
                        style: TextStyle(
                          fontFamily: FolioTypography.sans,
                          fontSize: 5.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.7,
                          color: p.ink,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      project.previewTitle,
                      style: TextStyle(
                        fontFamily: FolioTypography.serifFamily,
                        fontSize: 28,
                        height: 0.9,
                        fontStyle: FontStyle.italic,
                        color: p.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      project.previewSubtitle,
                      style: TextStyle(
                        fontFamily: FolioTypography.sans,
                        fontSize: 7,
                        color: p.ink.withValues(alpha: 0.74),
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
            for (final label in project.previewItems) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: p.start.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: FolioTypography.sans,
                    fontSize: 6.5,
                    fontWeight: FontWeight.w600,
                    color: p.start,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ],
        ),
        const SizedBox(height: 9),
        Text(
          'Langkah memasak',
          style: TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: p.onScreen,
          ),
        ),
        const SizedBox(height: 6),
        for (var i = 0; i < 2; i++) ...[
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: p.onScreen.withValues(alpha: 0.045),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: p.start,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                      color: p.ink,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    i == 0
                        ? 'Tumis bumbu sampai harum.'
                        : 'Masukkan santan, kecilkan api.',
                    style: TextStyle(
                      fontFamily: FolioTypography.sans,
                      fontSize: 7.5,
                      color: p.onScreen,
                    ),
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
