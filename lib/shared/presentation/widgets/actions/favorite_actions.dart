import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/common/app_feedback.dart';

void toggleFavorite(BuildContext context, Project project) {
  final wasSaved = context.read<FavoritesBloc>().state.isSaved(project.id);
  context.read<FavoritesBloc>().add(FavoriteToggled(project.id));
  showFolioSnackBar(
    context,
    message: wasSaved
        ? context.l10n.removedFromSaved(project.name)
        : context.l10n.savedNotice(project.name),
  );
}

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.project,
    this.background,
    this.foreground,
    this.size = 46,
    this.iconSize = 19,
    this.showBorder = false,
  });

  final Project project;
  final Color? background;
  final Color? foreground;
  final double size;
  final double iconSize;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) =>
          previous.isSaved(project.id) != current.isSaved(project.id),
      builder: (context, favorites) {
        final saved = favorites.isSaved(project.id);
        return SizedBox(
          width: size,
          height: size,
          child: Material(
            color: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size * 0.28),
              side: showBorder
                  ? BorderSide(color: context.folio.line)
                  : BorderSide.none,
            ),
            clipBehavior: Clip.antiAlias,
            child: IconButton(
              tooltip: saved
                  ? context.l10n.removeFromSaved
                  : context.l10n.saveProject,
              onPressed: () => toggleFavorite(context, project),
              icon: Icon(
                saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                size: iconSize,
                color: foreground,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FavoriteOutlineButton extends StatelessWidget {
  const FavoriteOutlineButton({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) =>
          previous.isSaved(project.id) != current.isSaved(project.id),
      builder: (context, favorites) {
        final saved = favorites.isSaved(project.id);
        return OutlinedButton.icon(
          onPressed: () => toggleFavorite(context, project),
          icon: Icon(
            saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            size: 17,
            color: saved ? colors.accent : colors.ink,
          ),
          label: Text(saved ? context.l10n.savedTab : context.l10n.save),
        );
      },
    );
  }
}
