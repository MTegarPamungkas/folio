import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  const FavoritesState({required this.ids});

  final Set<String> ids;

  bool isSaved(String projectId) => ids.contains(projectId);

  int get count => ids.length;

  @override
  List<Object?> get props => [ids];
}
