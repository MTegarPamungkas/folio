import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/domain/repositories/favorites_repository.dart';
import 'package:folio/domain/usecases/get_favorite_ids.dart';
import 'package:folio/domain/usecases/toggle_favorite.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_state.dart';

class _FakeFavoritesRepository implements FavoritesRepository {
  Set<String> ids = {};

  @override
  Set<String> getFavoriteIds() => ids;

  @override
  Future<void> saveFavoriteIds(Set<String> ids) async {
    this.ids = ids;
  }
}

void main() {
  late _FakeFavoritesRepository repository;

  setUp(() {
    repository = _FakeFavoritesRepository();
  });

  FavoritesBloc buildBloc() =>
      FavoritesBloc(GetFavoriteIds(repository), ToggleFavorite(repository));

  blocTest<FavoritesBloc, FavoritesState>(
    'adds a project and persists the new ids',
    build: buildBloc,
    act: (bloc) => bloc.add(const FavoriteToggled('mis-msa')),
    wait: const Duration(milliseconds: 20),
    expect: () => [
      const FavoritesState(ids: {'mis-msa'}),
    ],
    verify: (_) => expect(repository.ids, {'mis-msa'}),
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'removes an existing favorite',
    seed: () {
      repository.ids = {'mis-msa'};
      return const FavoritesState(ids: {'mis-msa'});
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const FavoriteToggled('mis-msa')),
    wait: const Duration(milliseconds: 20),
    expect: () => [const FavoritesState(ids: {})],
    verify: (_) => expect(repository.ids, isEmpty),
  );
}
