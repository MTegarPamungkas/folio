import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/domain/repositories/settings_repository.dart';

class GetLanguage {
  const GetLanguage(this._repository);

  final SettingsRepository _repository;

  AppLanguage call() => _repository.getLanguage();
}
