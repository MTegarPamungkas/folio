import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => const [];
}

final class SettingsThemeModeChanged extends SettingsEvent {
  const SettingsThemeModeChanged(this.mode);

  final AppThemeMode mode;

  @override
  List<Object?> get props => [mode];
}

final class SettingsThemeToggled extends SettingsEvent {
  const SettingsThemeToggled({required this.isCurrentlyDark});

  final bool isCurrentlyDark;

  @override
  List<Object?> get props => [isCurrentlyDark];
}
