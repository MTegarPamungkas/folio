import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/developer.dart';

class AboutState extends Equatable {
  const AboutState({this.developer});

  final Developer? developer;

  bool get isLoading => developer == null;

  @override
  List<Object?> get props => [developer];
}
