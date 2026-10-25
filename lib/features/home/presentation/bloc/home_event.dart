import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => const [];
}

final class HomeStarted extends HomeEvent {
  const HomeStarted();
}
