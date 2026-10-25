import 'package:equatable/equatable.dart';

sealed class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object?> get props => const [];
}

final class SavedFavoritesChanged extends SavedEvent {
  const SavedFavoritesChanged(this.ids);

  final Set<String> ids;

  @override
  List<Object?> get props => [ids];
}
