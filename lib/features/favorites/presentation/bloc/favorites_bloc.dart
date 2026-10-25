import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/usecases/get_favorite_ids.dart';
import 'package:folio/domain/usecases/toggle_favorite.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(GetFavoriteIds getFavoriteIds, this._toggleFavorite)
    : super(FavoritesState(ids: getFavoriteIds())) {
    on<FavoriteToggled>(_onFavoriteToggled);
  }

  final ToggleFavorite _toggleFavorite;

  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    final ids = await _toggleFavorite(
      currentIds: state.ids,
      projectId: event.projectId,
    );
    if (isClosed) return;
    emit(FavoritesState(ids: ids));
  }
}
