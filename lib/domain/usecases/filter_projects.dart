import 'package:folio/domain/entities/project.dart';

class FilterProjects {
  const FilterProjects();

  List<Project> call({
    required List<Project> projects,
    required String query,
    ProjectCategory? category,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    return projects
        .where((project) {
          final categoryMatches =
              category == null || project.category == category;
          return categoryMatches && project.matches(normalizedQuery);
        })
        .toList(growable: false);
  }
}
