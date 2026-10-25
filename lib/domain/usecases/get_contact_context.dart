import 'package:folio/domain/entities/contact_context.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';

class GetContactContext {
  const GetContactContext(this._repository);

  final PortfolioRepository _repository;

  ContactContext call(String? projectId) {
    final content = _repository.getContent();
    return ContactContext(
      developer: content.developer,
      project: projectId == null ? null : content.projectById(projectId),
    );
  }
}
