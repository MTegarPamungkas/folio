import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/explore/presentation/bloc/explore_event.dart';
import 'package:folio/shared/presentation/theme/project_visuals.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';
import 'package:folio/shared/presentation/widgets/common/app_surfaces.dart';
import 'package:go_router/go_router.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.counts});

  final Map<ProjectCategory, int> counts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeading(
          eyebrow: 'MULAI DARI SINI',
          title: 'Jelajahi kategori',
          subtitle: 'Temukan karya sesuai bidang yang sedang kamu cari.',
        ),
        const SizedBox(height: 22),
        AdaptiveColumns(
          minItemWidth: 150,
          maxColumns: 3,
          spacing: 11,
          runSpacing: 11,
          children: [
            for (final category in ProjectCategory.values.where(
              (category) => (counts[category] ?? 0) > 0,
            ))
              CategoryTile(
                category: category,
                count: counts[category] ?? 0,
                onTap: () {
                  final explore = context.read<ExploreBloc>();
                  explore
                    ..add(const ExploreFiltersCleared())
                    ..add(ExploreCategoryChanged(category));
                  context.go('/explore');
                },
              ),
          ],
        ),
      ],
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.count,
    required this.onTap,
  });

  final ProjectCategory category;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final palette = category.palette;

    return HoverLift(
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 92),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.line),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final narrow = constraints.maxWidth < 200;
                return Row(
                  children: [
                    Container(
                      width: narrow ? 40 : 44,
                      height: narrow ? 40 : 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [palette.start, palette.end],
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(category.icon, size: 20, color: palette.ink),
                    ),
                    SizedBox(width: narrow ? 9 : 11),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontSize: narrow ? 12.5 : 13),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '$count karya',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: 10,
                                  color: colors.inkMuted,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (!narrow)
                      Icon(
                        Icons.arrow_outward_rounded,
                        size: 15,
                        color: colors.inkMuted,
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
