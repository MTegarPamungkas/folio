import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/domain/usecases/get_language.dart';
import 'package:folio/domain/usecases/get_theme_mode.dart';
import 'package:folio/domain/usecases/set_language.dart';
import 'package:folio/domain/usecases/set_theme_mode.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'package:folio/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    GetThemeMode getThemeMode,
    GetLanguage getLanguage,
    this._setThemeMode,
    this._setLanguage,
  ) : super(SettingsState(themeMode: getThemeMode(), language: getLanguage())) {
    on<SettingsThemeModeChanged>(_onThemeModeChanged);
    on<SettingsThemeToggled>(_onThemeToggled);
    on<SettingsLanguageChanged>(_onLanguageChanged);
  }

  final SetThemeMode _setThemeMode;
  final SetLanguage _setLanguage;

  Future<void> _onThemeModeChanged(
    SettingsThemeModeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    await _applyTheme(event.mode, emit);
  }

  Future<void> _onThemeToggled(
    SettingsThemeToggled event,
    Emitter<SettingsState> emit,
  ) async {
    final target = event.isCurrentlyDark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    await _applyTheme(target, emit);
  }

  Future<void> _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final language = event.language;
    if (state.language == language) return;
    emit(state.copyWith(language: language));
    await _setLanguage(language);
  }

  Future<void> _applyTheme(
    AppThemeMode mode,
    Emitter<SettingsState> emit,
  ) async {
    if (state.themeMode == mode) return;
    emit(state.copyWith(themeMode: mode));
    await _setThemeMode(mode);
  }
}
