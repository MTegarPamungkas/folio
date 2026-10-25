import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/project.dart';

class SavedState extends Equatable {
  const SavedState({required this.projects});

  final List<Project> projects;

  bool get isEmpty => projects.isEmpty;

  @override
  List<Object?> get props => [projects];
}
