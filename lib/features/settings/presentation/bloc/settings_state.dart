import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.themeMode});

  final AppThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

extension AppThemeModePresentation on AppThemeMode {
  ThemeMode get materialThemeMode => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}
