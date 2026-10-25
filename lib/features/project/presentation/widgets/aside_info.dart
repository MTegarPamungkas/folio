import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/brand/developer_avatar.dart';
import 'package:folio/shared/presentation/widgets/common/app_controls.dart';
import 'package:go_router/go_router.dart';

class AsideInfo extends StatelessWidget {
  const AsideInfo({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    final initials = context.select<ProfileBloc, String>(
      (bloc) => bloc.state.developer.initials,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: colors.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Informasi', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TIPE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 7.5,
                            letterSpacing: 0.9,
                            color: colors.inkMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.type.label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            height: 1.25,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 42, color: colors.line),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TAHUN',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 7.5,
                            letterSpacing: 0.9,
                            color: colors.inkMuted,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          project.year,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 26,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Divider(color: colors.line),
              const SizedBox(height: 15),
              _InfoRow(label: 'Kategori', value: project.category.label),
              _InfoRow(label: 'Peran', value: project.role),
              _InfoRow(label: 'Durasi', value: project.timeline),
              _InfoRow(label: 'Status', value: project.status),
              _InfoRow(
                label: 'Platform',
                value: project.platformLabel,
                isLast: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: colors.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dibuat dengan', style: theme.textTheme.titleMedium),
              const SizedBox(height: 13),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  for (final tech in project.tech)
                    TechPill(label: tech, compact: true),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.ink,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeveloperAvatar(initials: initials, size: 38, showStatus: false),
              const SizedBox(height: 13),
              Text(
                'Tertarik dengan pendekatan ini?',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.background,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Ceritakan tantangan produkmu. Saya senang membantu memetakan '
                'langkah pertamanya.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.background.withValues(alpha: 0.62),
                  fontSize: 10.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () => context.push('/contact?project=${project.id}'),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Text(
                        'Mulai percakapan',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 13,
                        color: colors.accent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 78,
            child: Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 8.5,
                letterSpacing: 0.4,
                color: colors.inkMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10.5,
                height: 1.4,
                color: colors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
