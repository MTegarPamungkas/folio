import 'package:folio/domain/entities/developer.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';

class GetAboutContent {
  const GetAboutContent(this._repository);

  final PortfolioRepository _repository;

  Developer call() => _repository.getContent().developer;
}
