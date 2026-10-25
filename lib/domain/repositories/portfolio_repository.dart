import 'package:folio/domain/entities/portfolio_content.dart';

abstract interface class PortfolioRepository {
  PortfolioContent getContent();
}
