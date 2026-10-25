import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/domain/repositories/settings_repository.dart';

class SetThemeMode {
  const SetThemeMode(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppThemeMode mode) => _repository.saveThemeMode(mode);
}
