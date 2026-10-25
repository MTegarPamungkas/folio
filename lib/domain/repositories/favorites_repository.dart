abstract interface class FavoritesRepository {
  Set<String> getFavoriteIds();

  Future<void> saveFavoriteIds(Set<String> ids);
}
