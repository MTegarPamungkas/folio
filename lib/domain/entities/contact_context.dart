import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/developer.dart';
import 'package:folio/domain/entities/project.dart';

class ContactContext extends Equatable {
  const ContactContext({required this.developer, this.project});

  final Developer developer;
  final Project? project;

  @override
  List<Object?> get props => [developer, project];
}
