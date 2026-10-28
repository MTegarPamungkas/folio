import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/explore/presentation/bloc/explore_event.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';
import 'package:folio/shared/presentation/widgets/project/project_list_tile.dart';
import 'package:go_router/go_router.dart';

class LatestReleasesSection extends StatelessWidget {
  const LatestReleasesSection({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeading(
          eyebrow: context.l10n.justReleased,
          title: context.l10n.latestReleases,
          subtitle: context.l10n.latestReleasesBody,
          action: ArrowAction(
            label: context.l10n.exploreAll,
            onPressed: () {
              context.read<ExploreBloc>().add(const ExploreFiltersCleared());
              context.go('/explore');
            },
          ),
        ),
        const SizedBox(height: 22),
        AdaptiveColumns(
          minItemWidth: 400,
          maxColumns: 2,
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final project in projects)
              ProjectListTile(
                project: project,
                onTap: () => context.push('/project/${project.id}'),
              ),
          ],
        ),
      ],
    );
  }
}
