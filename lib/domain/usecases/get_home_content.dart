import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';

class GetHomeContent {
  const GetHomeContent(this._repository);

  final PortfolioRepository _repository;

  HomeContent call() {
    final content = _repository.getContent();
    return HomeContent(
      developer: content.developer,
      featuredProjects: content.featuredProjects,
      latestProjects: content.latestProjects,
      categoryCounts: content.categoryCounts,
      totalProjects: content.projects.length,
    );
  }
}
