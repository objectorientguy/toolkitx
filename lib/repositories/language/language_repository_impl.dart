import '../../data/models/language/check_new_language_keys_model.dart';
import '../../data/models/language/language_keys_model.dart';
import '../../data/models/language/languages_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  @override
  Future<LanguagesModel> fetchLanguages() async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}/api/common/GetLanguages");
    return LanguagesModel.fromJson(response);
  }

  @override
  Future<LanguageKeysModel> fetchLanguageKeys(int languageId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/common/getlanguagekeys?languageid=$languageId&syncdate=&pageno=-1");
    return LanguageKeysModel.fromJson(response);
  }

  @override
  Future<CheckNewLanguageKeysModel> isDownloadLanguage(int languageId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/common/IsDownloadLanguage?languageid=$languageId&syncdate=");
    return CheckNewLanguageKeysModel.fromJson(response);
  }
}
