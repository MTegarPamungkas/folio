import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/actions/favorite_actions.dart';
import 'package:folio/shared/presentation/widgets/brand/category_pill.dart';
import 'package:folio/shared/presentation/widgets/project/project_cover.dart';
import 'package:folio/shared/presentation/widgets/project/project_icon.dart';
import 'package:go_router/go_router.dart';

class ProjectHero extends StatelessWidget {
  const ProjectHero({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    final p = project.palette;
    final isDark = theme.brightness == Brightness.dark;
    final start = Color.lerp(colors.surface, p.start, isDark ? 0.38 : 0.24)!;
    final end = Color.lerp(colors.surface, p.end, isDark ? 0.3 : 0.17)!;
    final developerName = context.select<ProfileBloc, String>(
      (bloc) => bloc.state.developer.name,
    );

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CategoryPill(category: project.category),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: p.start.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: p.start,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      project.statusIn(context.language),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 8.5,
                        letterSpacing: 0.3,
                        color: colors.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectIcon(
              project: project,
              size: context.isCompact ? 76 : 96,
              showShadow: true,
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontSize: context.responsive<double>(
                        compact: 34,
                        medium: 40,
                        expanded: 45,
                      ),
                      letterSpacing: -1.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.taglineIn(context.language),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: context.isCompact ? 13 : 14.5,
                      height: 1.45,
                      color: colors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 14,
          runSpacing: 9,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              project.isWebsite
                  ? Icons.language_rounded
                  : Icons.phone_iphone_rounded,
              size: 14,
              color: colors.ink,
            ),
            Text(
              context.tr(project.type.label),
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: colors.ink,
              ),
            ),
            Text(
              project.highlightIn(context.language),
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 10.5),
            ),
            Text(
              project.year,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 10.5),
            ),
          ],
        ),
        const SizedBox(height: 22),
        if (context.isCompact)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PrimaryAction(project: project),
              const SizedBox(height: 9),
              FavoriteOutlineButton(project: project),
            ],
          )
        else
          Wrap(
            spacing: 9,
            runSpacing: 9,
            children: [
              _PrimaryAction(project: project),
              FavoriteOutlineButton(project: project),
            ],
          ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              context.trArgs('Saya, {name}', {'name': developerName}),
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10.5,
                color: colors.inkMuted,
              ),
            ),
            Icon(Icons.verified_rounded, size: 13, color: p.start),
          ],
        ),
      ],
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [start, end],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: colors.line.withValues(alpha: 0.85)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -100,
            top: -130,
            child: Container(
              width: 330,
              height: 330,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: p.start.withValues(alpha: 0.13)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26),
            child: AdaptiveTwoPane(
              breakpoint: 880,
              gap: 44,
              endWidth: 292,
              rowAlignment: CrossAxisAlignment.center,
              showEndOnCompact: false,
              start: info,
              end: _HeroPoster(project: project),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  const _PrimaryAction({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return FilledButton.icon(
      onPressed: () => context.push('/contact?project=${project.id}'),
      style: FilledButton.styleFrom(
        backgroundColor: colors.ink,
        foregroundColor: colors.background,
      ),
      icon: const Icon(Icons.arrow_outward_rounded, size: 17),
      label: Text(context.tr('Ajukan kolaborasi')),
    );
  }
}

class _HeroPoster extends StatelessWidget {
  const _HeroPoster({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Transform.rotate(
      angle: -0.025,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: colors.shadow,
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ProjectCover(project: project, height: 206, borderRadius: 23),
      ),
    );
  }
}
