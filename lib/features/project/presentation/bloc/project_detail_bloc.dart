import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/usecases/get_project_detail.dart';
import 'package:folio/features/project/presentation/bloc/project_detail_event.dart';
import 'package:folio/features/project/presentation/bloc/project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  ProjectDetailBloc(this._getProjectDetail, this.projectId)
    : super(ProjectDetailState(projectId: projectId)) {
    on<ProjectDetailStarted>(_onStarted);
  }

  final GetProjectDetail _getProjectDetail;
  final String projectId;

  void _onStarted(
    ProjectDetailStarted event,
    Emitter<ProjectDetailState> emit,
  ) {
    emit(
      ProjectDetailState(
        projectId: projectId,
        detail: _getProjectDetail(projectId),
        isLoading: false,
      ),
    );
  }
}
