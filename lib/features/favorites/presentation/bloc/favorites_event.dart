import 'package:equatable/equatable.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => const [];
}

final class FavoriteToggled extends FavoritesEvent {
  const FavoriteToggled(this.projectId);

  final String projectId;

  @override
  List<Object?> get props => [projectId];
}
