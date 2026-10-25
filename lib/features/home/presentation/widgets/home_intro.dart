import 'package:flutter/material.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';

class HomeIntro extends StatelessWidget {
  const HomeIntro({
    super.key,
    required this.developer,
    required this.projectCount,
  });

  final Developer developer;
  final int projectCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;
    final headingSize = context.responsive<double>(
      compact: 35,
      medium: 50,
      expanded: 62,
    );

    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('Personal app store · 2026'),
        const SizedBox(height: 18),
        Text.rich(
          TextSpan(
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: headingSize,
              height: 1.01,
              letterSpacing: headingSize * -0.045,
            ),
            children: [
              const TextSpan(text: 'Temukan '),
              TextSpan(
                text: 'karya',
                style: FolioTypography.serif(
                  fontSize: headingSize * 1.06,
                  color: colors.accent,
                  height: 0.92,
                  letterSpacing: -1,
                ),
              ),
              const TextSpan(text: ' yang\nsedang saya bangun.'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 590),
          child: Text(
            'Portofolio dalam bentuk app store. Jelajahi aplikasi dan '
            'website yang saya bangun, buka studi kasusnya, dan simpan '
            'yang paling relevan untukmu.',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: context.isExpanded ? 16.5 : 15,
              height: 1.65,
              color: colors.inkMuted,
            ),
          ),
        ),
      ],
    );

    return AdaptiveTwoPane(
      breakpoint: 840,
      gap: 52,
      compactGap: 24,
      endWidth: 286,
      rowAlignment: CrossAxisAlignment.end,
      start: heading,
      end: IntroStats(developer: developer, projectCount: projectCount),
    );
  }
}

class IntroStats extends StatelessWidget {
  const IntroStats({
    super.key,
    required this.developer,
    required this.projectCount,
  });

  final Developer developer;
  final int projectCount;

  @override
  Widget build(BuildContext context) {
    final items = [
      (projectCount.toString().padLeft(2, '0'), 'Karya pilihan'),
      ('${developer.projectCount}', 'Proyek & modul'),
      ('${developer.yearsExperience}+', 'Pengalaman'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontal = constraints.maxWidth >= 330;
        final colors = context.folio;

        if (horizontal) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: _StatCard(value: items[i].$1, label: items[i].$2),
                ),
              ],
            ],
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.line),
          ),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) Divider(color: colors.line, height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Row(
                    children: [
                      Text(
                        items[i].$1,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontSize: 25, letterSpacing: -1),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          items[i].$2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 11.5,
                                color: colors.inkMuted,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 23, letterSpacing: -0.8),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 9.5,
              color: colors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}
