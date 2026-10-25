import 'package:equatable/equatable.dart';

sealed class ProjectDetailEvent extends Equatable {
  const ProjectDetailEvent();

  @override
  List<Object?> get props => const [];
}

final class ProjectDetailStarted extends ProjectDetailEvent {
  const ProjectDetailStarted();
}
