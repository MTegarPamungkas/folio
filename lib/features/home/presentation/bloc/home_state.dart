import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/portfolio_content.dart';

class HomeState extends Equatable {
  const HomeState({this.content});

  final HomeContent? content;

  bool get isLoading => content == null;

  @override
  List<Object?> get props => [content];
}
