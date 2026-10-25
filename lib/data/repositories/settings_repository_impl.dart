import 'package:folio/data/datasources/preferences_local_data_source.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._localDataSource);

  final PreferencesLocalDataSource _localDataSource;

  @override
  AppThemeMode getThemeMode() => _localDataSource.getThemeMode();

  @override
  Future<void> saveThemeMode(AppThemeMode mode) =>
      _localDataSource.setThemeMode(mode);
}
