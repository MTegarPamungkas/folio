import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/domain/repositories/settings_repository.dart';

class GetThemeMode {
  const GetThemeMode(this._repository);

  final SettingsRepository _repository;

  AppThemeMode call() => _repository.getThemeMode();
}
