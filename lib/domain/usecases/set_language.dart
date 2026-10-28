import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/domain/repositories/settings_repository.dart';

class SetLanguage {
  const SetLanguage(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppLanguage language) => _repository.saveLanguage(language);
}
