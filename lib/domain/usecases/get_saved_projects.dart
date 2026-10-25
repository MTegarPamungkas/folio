import 'package:folio/domain/entities/project.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';

class GetSavedProjects {
  const GetSavedProjects(this._repository);

  final PortfolioRepository _repository;

  List<Project> call(Set<String> ids) {
    if (ids.isEmpty) return const [];
    return _repository
        .getContent()
        .projects
        .where((project) => ids.contains(project.id))
        .toList(growable: false);
  }
}
