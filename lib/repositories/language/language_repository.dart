import '../../data/models/language/check_new_language_keys_model.dart';
import '../../data/models/language/language_keys_model.dart';
import '../../data/models/language/languages_model.dart';

abstract class LanguageRepository {
  Future<LanguagesModel> fetchLanguages();

  Future<LanguageKeysModel> fetchLanguageKeys(int languageId);

  Future<CheckNewLanguageKeysModel> isDownloadLanguage(int languageId);
}
