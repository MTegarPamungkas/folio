import 'package:folio/domain/entities/app_theme_mode.dart';

abstract interface class SettingsRepository {
  AppThemeMode getThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}
