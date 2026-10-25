import 'package:flutter/material.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({
    super.key,
    required this.education,
    required this.organizations,
  });

  final List<EducationItem> education;
  final List<OrganizationItem> organizations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeading(
          eyebrow: 'Pendidikan & organisasi',
          title: 'Tempat saya belajar dan tumbuh',
          subtitle:
              'Dasar teknis dari bangku sekolah dan kuliah, dilengkapi pengalaman organisasi.',
        ),
        const SizedBox(height: 24),
        AdaptiveTwoPane(
          breakpoint: 800,
          gap: 28,
          compactGap: 22,
          start: _Column(
            label: 'PENDIDIKAN',
            children: [
              for (var i = 0; i < education.length; i++)
                _EducationCard(
                  item: education[i],
                  isLast: i == education.length - 1,
                ),
            ],
          ),
          end: _Column(
            label: 'ORGANISASI',
            children: [
              for (var i = 0; i < organizations.length; i++)
                _OrganizationCard(
                  item: organizations[i],
                  isLast: i == organizations.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.label, required this.children});

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 8.5,
            letterSpacing: 1.2,
            color: colors.inkMuted,
          ),
        ),
        const SizedBox(height: 11),
        ...children,
      ],
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.item, required this.isLast});

  final EducationItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 9),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBox(icon: Icons.school_outlined),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.degree,
                  style: theme.textTheme.titleSmall?.copyWith(height: 1.3),
                ),
                const SizedBox(height: 4),
                Text(
                  item.institution,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: colors.inkMuted,
                  ),
                ),
                const SizedBox(height: 7),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      item.period,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 8.5,
                        letterSpacing: 0.5,
                        color: colors.inkMuted,
                      ),
                    ),
                    Text(
                      '·',
                      style: TextStyle(color: colors.inkMuted, fontSize: 9),
                    ),
                    Text(
                      item.location,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 8.5,
                        letterSpacing: 0.5,
                        color: colors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrganizationCard extends StatelessWidget {
  const _OrganizationCard({required this.item, required this.isLast});

  final OrganizationItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 9),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBox(icon: Icons.groups_2_outlined),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.role,
                  style: theme.textTheme.titleSmall?.copyWith(height: 1.3),
                ),
                const SizedBox(height: 4),
                Text(
                  item.organization,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: colors.inkMuted,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item.period,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 8.5,
                    letterSpacing: 0.5,
                    color: colors.inkMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: colors.accentSoft,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 17, color: colors.ink),
    );
  }
}
