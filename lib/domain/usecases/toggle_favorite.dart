import 'package:folio/domain/repositories/favorites_repository.dart';

class ToggleFavorite {
  const ToggleFavorite(this._repository);

  final FavoritesRepository _repository;

  Future<Set<String>> call({
    required Set<String> currentIds,
    required String projectId,
  }) async {
    final next = Set<String>.of(currentIds);
    if (!next.add(projectId)) {
      next.remove(projectId);
    }
    await _repository.saveFavoriteIds(next);
    return Set.unmodifiable(next);
  }
}
