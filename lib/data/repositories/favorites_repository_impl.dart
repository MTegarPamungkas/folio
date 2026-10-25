import 'package:folio/data/datasources/preferences_local_data_source.dart';
import 'package:folio/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._localDataSource);

  final PreferencesLocalDataSource _localDataSource;

  @override
  Set<String> getFavoriteIds() => _localDataSource.getFavoriteIds();

  @override
  Future<void> saveFavoriteIds(Set<String> ids) =>
      _localDataSource.setFavoriteIds(ids);
}
