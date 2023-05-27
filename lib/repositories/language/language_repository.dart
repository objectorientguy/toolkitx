import '../../data/models/language/check_new_language_keys_model.dart';
import '../../data/models/language/language_keys_model.dart';
import '../../data/models/language/languages_model.dart';

abstract class LanguageRepository {
  Future<LanguagesModel> fetchLanguages();

  Future<LanguageKeysModel> fetchLanguageKeys(
      int languageId, String syncDate, int pageNo);

  Future<CheckNewLanguageKeysModel> isDownloadLanguage(
      int languageId, String syncDate);
}
