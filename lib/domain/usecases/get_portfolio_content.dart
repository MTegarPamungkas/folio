import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';

class GetPortfolioContent {
  const GetPortfolioContent(this._repository);

  final PortfolioRepository _repository;

  PortfolioContent call() => _repository.getContent();
}
