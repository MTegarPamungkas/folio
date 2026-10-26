import 'package:flutter/material.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';

class PrinciplesSection extends StatelessWidget {
  const PrinciplesSection({super.key, required this.principles});

  final List<Principle> principles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeading(
          eyebrow: 'Cara saya bekerja',
          title: 'Prinsip yang saya pegang',
          subtitle: 'Ini bukan aturan kaku—cuma cara saya mengambil keputusan.',
        ),
        const SizedBox(height: 22),
        AdaptiveColumns(
          minItemWidth: 260,
          maxColumns: 3,
          spacing: 12,
          runSpacing: 12,
          children: [
            for (var i = 0; i < principles.length; i++)
              _PrincipleCard(principle: principles[i], index: i + 1),
          ],
        ),
      ],
    );
  }
}

class _PrincipleCard extends StatelessWidget {
  const _PrincipleCard({required this.principle, required this.index});

  final Principle principle;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colors.accentSoft,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(principle.icon, size: 20, color: colors.accent),
              ),
              const Spacer(),
              Text(
                index.toString().padLeft(2, '0'),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: colors.inkMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          Text(principle.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 7),
          Text(
            principle.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
              height: 1.6,
              color: colors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}
