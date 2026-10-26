import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/explore/presentation/bloc/explore_event.dart';
import 'package:folio/features/explore/presentation/bloc/explore_state.dart';
import 'package:folio/features/explore/presentation/widgets/category_filter_bar.dart';
import 'package:folio/features/explore/presentation/widgets/explore_search_field.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:folio/shared/presentation/widgets/actions/favorite_actions.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';
import 'package:folio/shared/presentation/widgets/common/app_surfaces.dart';
import 'package:folio/shared/presentation/widgets/footer/folio_footer.dart';
import 'package:folio/shared/presentation/widgets/project/project_grid_card.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;

    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        return AdaptivePage(
          topPadding: 28,
          bottomPadding: 24,
          children: [
            PageIntro(
              eyebrow: 'Jelajah koleksi',
              title: Text.rich(
                TextSpan(
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: context.responsive<double>(
                      compact: 40,
                      medium: 48,
                      expanded: 48,
                    ),
                    letterSpacing: -1.7,
                  ),
                  children: [
                    const TextSpan(text: 'Temukan '),
                    TextSpan(
                      text: 'semua karya.',
                      style: FolioTypography.serif(
                        fontSize: context.responsive<double>(
                          compact: 43,
                          medium: 52,
                          expanded: 52,
                        ),
                        color: colors.accent,
                        height: 0.95,
                        letterSpacing: -1.2,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle:
                  'Cari berdasarkan nama proyek, teknologi, atau kategori. '
                  'Semua studi kasus saya ada di sini.',
            ),
            const SizedBox(height: 28),
            ExploreSearchField(
              query: state.query,
              onChanged: (query) =>
                  context.read<ExploreBloc>().add(ExploreQueryChanged(query)),
              onClear: () => context.read<ExploreBloc>().add(
                const ExploreQueryChanged(''),
              ),
            ),
            const SizedBox(height: 16),
            CategoryFilterBar(
              selected: state.selectedCategory,
              categories: state.availableCategories,
              onSelected: (category) => context.read<ExploreBloc>().add(
                ExploreCategoryChanged(category),
              ),
            ),
            const SizedBox(height: 24),
            _ResultsHeader(state: state),
            const SizedBox(height: 12),
            if (state.results.isEmpty)
              EmptyCollection(
                icon: Icons.search_off_rounded,
                title: 'Belum ada yang cocok',
                message:
                    'Coba kata kunci lain, atau hapus filter kategorinya '
                    'buat lihat semua karya.',
                action: OutlinedButton(
                  onPressed: () => context.read<ExploreBloc>().add(
                    const ExploreFiltersCleared(),
                  ),
                  child: const Text('Tampilkan semua'),
                ),
              )
            else
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favorites) {
                  return AdaptiveColumns(
                    minItemWidth: 300,
                    maxColumns: 3,
                    spacing: 14,
                    runSpacing: 14,
                    itemHeight: 342,
                    children: [
                      for (final project in state.results)
                        ProjectGridCard(
                          project: project,
                          saved: favorites.isSaved(project.id),
                          onToggleSaved: () => toggleFavorite(context, project),
                          onTap: () => context.push('/project/${project.id}'),
                        ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 44),
            const FolioFooter(),
          ],
        );
      },
    );
  }
}

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({required this.state});

  final ExploreState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;
    final filtering = state.isFiltering;

    return Row(
      children: [
        Semantics(
          liveRegion: true,
          child: Text(
            filtering
                ? '${state.results.length} hasil ditemukan'
                : '${state.results.length} karya pilihan',
            style: theme.textTheme.titleSmall?.copyWith(fontSize: 13),
          ),
        ),
        const SizedBox(width: 8),
        if (filtering)
          Flexible(
            child: Text(
              state.query.trim().isNotEmpty
                  ? 'untuk “${state.query.trim()}”'
                  : 'di ${state.selectedCategory?.label}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 11,
                color: colors.inkMuted,
              ),
            ),
          ),
        const Spacer(),
        if (filtering)
          TextButton.icon(
            onPressed: () =>
                context.read<ExploreBloc>().add(const ExploreFiltersCleared()),
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            icon: const Icon(Icons.close_rounded, size: 15),
            label: const Text('Reset'),
          ),
      ],
    );
  }
}
