import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/usecases/get_saved_projects.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:folio/features/saved/presentation/bloc/saved_event.dart';
import 'package:folio/features/saved/presentation/bloc/saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc(this._favoritesBloc, this._getSavedProjects)
    : super(SavedState(projects: _getSavedProjects(_favoritesBloc.state.ids))) {
    on<SavedFavoritesChanged>(_onFavoritesChanged);
    _favoritesSubscription = _favoritesBloc.stream.listen((favorites) {
      add(SavedFavoritesChanged(favorites.ids));
    });
  }

  final FavoritesBloc _favoritesBloc;
  final GetSavedProjects _getSavedProjects;
  late final StreamSubscription<FavoritesState> _favoritesSubscription;

  void _onFavoritesChanged(
    SavedFavoritesChanged event,
    Emitter<SavedState> emit,
  ) {
    emit(SavedState(projects: _getSavedProjects(event.ids)));
  }

  @override
  Future<void> close() {
    unawaited(_favoritesSubscription.cancel());
    return super.close();
  }
}
