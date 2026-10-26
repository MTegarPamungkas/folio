import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/explore/presentation/bloc/explore_event.dart';
import 'package:folio/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:folio/features/saved/presentation/bloc/saved_state.dart';
import 'package:folio/shared/presentation/widgets/actions/favorite_actions.dart';
import 'package:folio/shared/presentation/widgets/common/app_section.dart';
import 'package:folio/shared/presentation/widgets/common/app_surfaces.dart';
import 'package:folio/shared/presentation/widgets/footer/folio_footer.dart';
import 'package:folio/shared/presentation/widgets/project/project_grid_card.dart';
import 'package:go_router/go_router.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.folio;

    return BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) {
        return AdaptivePage(
          topPadding: 28,
          bottomPadding: 24,
          children: [
            PageIntro(
              eyebrow: 'Koleksi pribadi',
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
                    const TextSpan(text: 'Karya yang\nkamu '),
                    TextSpan(
                      text: 'simpan.',
                      style: FolioTypography.serif(
                        fontSize: context.responsive<double>(
                          compact: 43,
                          medium: 52,
                          expanded: 52,
                        ),
                        color: colors.accent,
                        height: 0.95,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 14,
                  color: colors.inkMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Hanya tersimpan di perangkat ini.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11.5,
                      color: colors.inkMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            if (state.isEmpty)
              EmptyCollection(
                icon: Icons.bookmark_border_rounded,
                title: 'Belum ada karya tersimpan',
                message:
                    'Ketuk ikon simpan di proyek buat menyimpannya di sini. '
                    'Koleksimu tetap ada saat kamu kembali.',
                action: FilledButton.icon(
                  onPressed: () {
                    context.read<ExploreBloc>().add(
                      const ExploreFiltersCleared(),
                    );
                    context.go('/explore');
                  },
                  icon: const Icon(Icons.explore_outlined, size: 18),
                  label: const Text('Mulai jelajah'),
                ),
              )
            else ...[
              Row(
                children: [
                  Text(
                    '${state.projects.length} karya tersimpan',
                    style: theme.textTheme.titleSmall?.copyWith(fontSize: 13),
                  ),
                  const Spacer(),
                  ArrowAction(
                    label: 'Tambah karya',
                    onPressed: () => context.go('/explore'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AdaptiveColumns(
                minItemWidth: 300,
                maxColumns: 3,
                spacing: 14,
                runSpacing: 14,
                itemHeight: 342,
                children: [
                  for (final project in state.projects)
                    ProjectGridCard(
                      project: project,
                      saved: true,
                      onToggleSaved: () => toggleFavorite(context, project),
                      onTap: () => context.push('/project/${project.id}'),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 48),
            const FolioFooter(),
          ],
        );
      },
    );
  }
}
