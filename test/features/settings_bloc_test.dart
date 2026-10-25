import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/domain/repositories/settings_repository.dart';
import 'package:folio/domain/usecases/get_theme_mode.dart';
import 'package:folio/domain/usecases/set_theme_mode.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'package:folio/features/settings/presentation/bloc/settings_state.dart';

class _FakeSettingsRepository implements SettingsRepository {
  AppThemeMode mode = AppThemeMode.system;

  @override
  AppThemeMode getThemeMode() => mode;

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    this.mode = mode;
  }
}

void main() {
  late _FakeSettingsRepository repository;

  setUp(() {
    repository = _FakeSettingsRepository();
  });

  SettingsBloc buildBloc() =>
      SettingsBloc(GetThemeMode(repository), SetThemeMode(repository));

  blocTest<SettingsBloc, SettingsState>(
    'emits and persists the selected theme',
    build: buildBloc,
    act: (bloc) => bloc.add(const SettingsThemeModeChanged(AppThemeMode.dark)),
    expect: () => [const SettingsState(themeMode: AppThemeMode.dark)],
    verify: (_) => expect(repository.mode, AppThemeMode.dark),
  );

  blocTest<SettingsBloc, SettingsState>(
    'toggle chooses the opposite mode through an event',
    build: buildBloc,
    act: (bloc) => bloc.add(const SettingsThemeToggled(isCurrentlyDark: true)),
    expect: () => [const SettingsState(themeMode: AppThemeMode.light)],
    verify: (_) => expect(repository.mode, AppThemeMode.light),
  );
}
