import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/project.dart';

class ExploreState extends Equatable {
  const ExploreState({
    required this.allProjects,
    required this.results,
    this.query = '',
    this.selectedCategory,
  });

  final List<Project> allProjects;
  final List<Project> results;
  final String query;
  final ProjectCategory? selectedCategory;

  bool get isFiltering => query.trim().isNotEmpty || selectedCategory != null;

  List<ProjectCategory> get availableCategories => [
    for (final category in ProjectCategory.values)
      if (allProjects.any((project) => project.category == category)) category,
  ];

  ExploreState copyWith({
    List<Project>? allProjects,
    List<Project>? results,
    String? query,
    ProjectCategory? selectedCategory,
    bool clearCategory = false,
  }) {
    return ExploreState(
      allProjects: allProjects ?? this.allProjects,
      results: results ?? this.results,
      query: query ?? this.query,
      selectedCategory: clearCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [allProjects, results, query, selectedCategory];
}
