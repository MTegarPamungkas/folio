import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/explore/presentation/bloc/explore_event.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';
import 'package:folio/shared/presentation/widgets/project/project_mini_tile.dart';
import 'package:go_router/go_router.dart';

class RelatedProjects extends StatelessWidget {
  const RelatedProjects({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeading(
          eyebrow: context.l10n.keepExploring,
          title: context.l10n.relatedTitle,
          action: ArrowAction(
            label: context.l10n.seeAll,
            onPressed: () {
              context.read<ExploreBloc>().add(const ExploreFiltersCleared());
              context.go('/explore');
            },
          ),
        ),
        const SizedBox(height: 18),
        AdaptiveColumns(
          minItemWidth: 220,
          maxColumns: 3,
          spacing: 11,
          runSpacing: 11,
          children: [
            for (final project in projects)
              ProjectMiniTile(
                project: project,
                onTap: () => context.pushReplacement('/project/${project.id}'),
              ),
          ],
        ),
      ],
    );
  }
}
