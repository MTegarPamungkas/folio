import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/domain/usecases/get_theme_mode.dart';
import 'package:folio/domain/usecases/set_theme_mode.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'package:folio/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(GetThemeMode getThemeMode, this._setThemeMode)
    : super(SettingsState(themeMode: getThemeMode())) {
    on<SettingsThemeModeChanged>(_onThemeModeChanged);
    on<SettingsThemeToggled>(_onThemeToggled);
  }

  final SetThemeMode _setThemeMode;

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

  Future<void> _applyTheme(
    AppThemeMode mode,
    Emitter<SettingsState> emit,
  ) async {
    if (state.themeMode == mode) return;
    emit(SettingsState(themeMode: mode));
    await _setThemeMode(mode);
  }
}
