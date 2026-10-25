import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/entities/project.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';

class GetProjectDetail {
  const GetProjectDetail(this._repository);

  final PortfolioRepository _repository;

  ProjectDetail? call(String projectId) {
    final content = _repository.getContent();
    final project = content.projectById(projectId);
    if (project == null) return null;

    final related =
        content.projects
            .where((candidate) => candidate.id != project.id)
            .toList()
          ..sort((a, b) {
            final aScore = _relatedScore(a, project);
            final bScore = _relatedScore(b, project);
            return bScore.compareTo(aScore);
          });

    return ProjectDetail(
      project: project,
      relatedProjects: related.take(3).toList(growable: false),
    );
  }

  int _relatedScore(Project candidate, Project project) {
    var score = 0;
    if (candidate.category == project.category) score += 100;
    if (candidate.type == project.type) score += 20;
    if (candidate.year == project.year) score += 10;
    if (candidate.featured) score += 5;
    return score;
  }
}
