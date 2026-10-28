import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.themeMode, required this.language});

  final AppThemeMode themeMode;
  final AppLanguage language;

  SettingsState copyWith({AppThemeMode? themeMode, AppLanguage? language}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [themeMode, language];
}

extension AppThemeModePresentation on AppThemeMode {
  ThemeMode get materialThemeMode => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}

extension AppLanguagePresentation on AppLanguage {
  Locale get locale => switch (this) {
    AppLanguage.id => const Locale('id'),
    AppLanguage.en => const Locale('en'),
  };
}
