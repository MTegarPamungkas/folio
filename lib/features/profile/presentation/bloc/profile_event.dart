import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => const [];
}

final class ProfileRefreshRequested extends ProfileEvent {
  const ProfileRefreshRequested();
}
