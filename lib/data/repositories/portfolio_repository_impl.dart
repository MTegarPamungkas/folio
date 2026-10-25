import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl(this._content);

  final PortfolioContent _content;

  @override
  PortfolioContent getContent() => _content;
}
