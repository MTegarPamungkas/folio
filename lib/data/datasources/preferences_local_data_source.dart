import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesLocalDataSource {
  const PreferencesLocalDataSource(this._preferences);

  static const _themeKey = 'folio.themeMode';
  static const _languageKey = 'folio.language';
  static const _savedKey = 'folio.savedProjects';

  final SharedPreferences _preferences;

  AppThemeMode getThemeMode() =>
      AppThemeMode.fromStorage(_preferences.getString(_themeKey));

  Future<void> setThemeMode(AppThemeMode mode) {
    return _preferences.setString(_themeKey, mode.name);
  }

  AppLanguage getLanguage() =>
      AppLanguage.fromCode(_preferences.getString(_languageKey));

  Future<void> setLanguage(AppLanguage language) {
    return _preferences.setString(_languageKey, language.code);
  }

  Set<String> getFavoriteIds() =>
      (_preferences.getStringList(_savedKey) ?? const []).toSet();

  Future<void> setFavoriteIds(Set<String> ids) {
    return _preferences.setStringList(_savedKey, ids.toList(growable: false));
  }
}
