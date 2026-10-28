import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/domain/entities/project.dart';

class PortfolioContent extends Equatable {
  const PortfolioContent({
    required this.developer,
    required this.projects,
    required this.latestProjectIds,
  });

  final Developer developer;
  final List<Project> projects;

  /// Project ids shown in the "Rilis terbaru" section, in display order.
  final List<String> latestProjectIds;

  Project? projectById(String id) {
    for (final project in projects) {
      if (project.id == id) return project;
    }
    return null;
  }

  List<Project> get featuredProjects =>
      projects.where((project) => project.featured).toList(growable: false);

  List<Project> get latestProjects => latestProjectIds
      .map(projectById)
      .whereType<Project>()
      .toList(growable: false);

  Map<ProjectCategory, int> get categoryCounts => {
    for (final category in ProjectCategory.values)
      category: projects
          .where((project) => project.category == category)
          .length,
  };

  @override
  List<Object?> get props => [developer, projects, latestProjectIds];
}

class HomeContent extends Equatable {
  const HomeContent({
    required this.developer,
    required this.featuredProjects,
    required this.latestProjects,
    required this.categoryCounts,
    required this.totalProjects,
  });

  final Developer developer;
  final List<Project> featuredProjects;
  final List<Project> latestProjects;
  final Map<ProjectCategory, int> categoryCounts;
  final int totalProjects;

  @override
  List<Object?> get props => [
    developer,
    featuredProjects,
    latestProjects,
    categoryCounts,
    totalProjects,
  ];
}

class ProjectDetail extends Equatable {
  const ProjectDetail({required this.project, required this.relatedProjects});

  final Project project;
  final List<Project> relatedProjects;

  @override
  List<Object?> get props => [project, relatedProjects];
}
