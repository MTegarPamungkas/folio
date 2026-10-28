import 'package:flutter/material.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/common/app_controls.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.groups});

  final List<SkillGroup> groups;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeading(
          eyebrow: context.tr('Perangkat kerja'),
          title: context.tr('Hal yang saya kuasai'),
          subtitle: context.tr(
            'Dari merancang alur di Figma sampai merilis build yang stabil.',
          ),
        ),
        const SizedBox(height: 22),
        AdaptiveColumns(
          minItemWidth: 280,
          maxColumns: 2,
          spacing: 12,
          runSpacing: 12,
          children: [for (final group in groups) _SkillGroupCard(group: group)],
        ),
      ],
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group});

  final SkillGroup group;

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
              Icon(group.icon, size: 18, color: colors.inkMuted),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  context.tr(group.title),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                context.trArgs('{count} tools', {
                  'count': '${group.skills.length}'.padLeft(2, '0'),
                }),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 8.5,
                  color: colors.inkMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              for (final skill in group.skills)
                TechPill(label: skill, compact: true),
            ],
          ),
        ],
      ),
    );
  }
}
