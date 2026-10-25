import 'package:flutter/material.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;
    final paragraphs = project.story.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailSectionTitle(
          eyebrow: 'STUDI KASUS',
          title: 'Tentang proyek ini',
        ),
        const SizedBox(height: 14),
        Text(
          project.description,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 17,
            height: 1.6,
            color: colors.ink,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < paragraphs.length; i++) ...[
          Text(
            paragraphs[i],
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 13.5,
              height: 1.75,
              color: colors.inkMuted,
            ),
          ),
          if (i != paragraphs.length - 1) const SizedBox(height: 13),
        ],
        const SizedBox(height: 31),
        const DetailSectionTitle(
          eyebrow: 'YANG SAYA RANCANG',
          title: 'Fitur utama',
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < project.features.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 11),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: colors.accentSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: colors.accent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    project.features[i],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      height: 1.55,
                      color: colors.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 27),
        ReleaseNotes(project: project),
      ],
    );
  }
}

class ReleaseNotes extends StatelessWidget {
  const ReleaseNotes({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
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
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: colors.surfaceMuted,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: colors.inkMuted,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text('Yang baru', style: theme.textTheme.titleMedium),
              ),
              Text(
                'v${project.version} · ${project.updatedAt}',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 8.5,
                  color: colors.inkMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          for (final note in project.releaseNotes)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                      color: colors.inkMuted,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      note,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11.5,
                        height: 1.5,
                        color: colors.inkMuted,
                      ),
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

class DetailSectionTitle extends StatelessWidget {
  const DetailSectionTitle({
    super.key,
    required this.eyebrow,
    required this.title,
  });

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 8.5,
            letterSpacing: 1.2,
            color: colors.inkMuted,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(fontSize: 22),
        ),
      ],
    );
  }
}
