import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/project.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => const [];
}

final class ExploreQueryChanged extends ExploreEvent {
  const ExploreQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ExploreCategoryChanged extends ExploreEvent {
  const ExploreCategoryChanged(this.category);

  final ProjectCategory? category;

  @override
  List<Object?> get props => [category];
}

final class ExploreFiltersCleared extends ExploreEvent {
  const ExploreFiltersCleared();
}
