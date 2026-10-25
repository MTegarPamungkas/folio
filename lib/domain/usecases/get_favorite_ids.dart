import 'package:folio/domain/repositories/favorites_repository.dart';

class GetFavoriteIds {
  const GetFavoriteIds(this._repository);

  final FavoritesRepository _repository;

  Set<String> call() => Set.unmodifiable(_repository.getFavoriteIds());
}
