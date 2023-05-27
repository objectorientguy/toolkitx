import '../../data/models/language/dowanload_language.dart';
import '../../data/models/language/get_language_keys.dart';
import '../../data/models/language/get_languages_model.dart';

abstract class LanguageRepository {
  Future<GetLanguagesModel> fetchLanguages();

  Future<GetLanguageKeysModel> fetchLanguageKeys(
      int languageId, String syncDate, int pageNo);

  Future<DownloadLanguageModel> isDownloadLanguage(
      int languageId, String syncDate);
}
