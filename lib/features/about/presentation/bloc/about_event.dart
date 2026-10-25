import 'package:equatable/equatable.dart';

sealed class AboutEvent extends Equatable {
  const AboutEvent();

  @override
  List<Object?> get props => const [];
}

final class AboutStarted extends AboutEvent {
  const AboutStarted();
}
