import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/portfolio_content.dart';

class ProjectDetailState extends Equatable {
  const ProjectDetailState({
    required this.projectId,
    this.detail,
    this.isLoading = true,
  });

  final String projectId;
  final ProjectDetail? detail;
  final bool isLoading;

  bool get found => detail != null;

  @override
  List<Object?> get props => [projectId, detail, isLoading];
}
