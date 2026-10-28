import 'package:flutter/material.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.items});

  final List<ExperienceItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeading(
          eyebrow: context.tr('Perjalanan'),
          title: context.tr('Belajar sambil membangun'),
          subtitle: context.tr(
            'Dari magang dan Bangkit Academy sampai aplikasi enterprise yang dipakai di lapangan.',
          ),
        ),
        const SizedBox(height: 28),
        for (var i = 0; i < items.length; i++)
          _TimelineItem(item: items[i], isLast: i == items.length - 1),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.item, required this.isLast});

  final ExperienceItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    final compact = context.isCompact;
    final language = context.language;
    final periodWidth = compact ? 0.0 : 142.0;
    final lineLeft = periodWidth + 9.5;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (compact) ...[
          Text(
            item.periodIn(language),
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 9,
              letterSpacing: 0.7,
              color: item.current ? colors.accent : colors.inkMuted,
            ),
          ),
          const SizedBox(height: 5),
        ],
        Row(
          children: [
            Flexible(
              child: Text(item.role, style: theme.textTheme.titleMedium),
            ),
            if (item.current) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.accentSoft,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  context.tr('SEKARANG'),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 7.5,
                    letterSpacing: 0.7,
                    color: colors.ink,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 3),
        Text(
          item.company,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 11.5,
            color: colors.inkMuted,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            item.descriptionIn(language),
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 12,
              height: 1.6,
              color: colors.inkMuted,
            ),
          ),
        ),
      ],
    );

    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: lineLeft,
            top: 17,
            bottom: 0,
            child: Container(width: 1, color: colors.line),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!compact)
              SizedBox(
                width: periodWidth,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, right: 18),
                  child: Text(
                    item.periodIn(language),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 9.5,
                      letterSpacing: 0.7,
                      color: item.current ? colors.accent : colors.inkMuted,
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: 20,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 11,
                  height: 11,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: item.current ? colors.accent : colors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: item.current ? colors.accent : colors.line,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, bottom: isLast ? 0 : 28),
                child: content,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
