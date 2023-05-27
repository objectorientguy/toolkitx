import 'package:toolkit/data/models/language/dowanload_language.dart';

import '../../data/models/language/get_language_keys.dart';
import '../../data/models/language/get_languages_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  @override
  Future<GetLanguagesModel> fetchLanguages() async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}/api/common/GetLanguages");
    return GetLanguagesModel.fromJson(response);
  }

  @override
  Future<GetLanguageKeysModel> fetchLanguageKeys(
      int languageId, String syncDate, int pageNo) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/common/getlanguagekeys?languageid=$languageId&syncdate=$syncDate&pageno=$pageNo");
    return GetLanguageKeysModel.fromJson(response);
  }

  @override
  Future<DownloadLanguageModel> isDownloadLanguage(
      int languageId, String syncDate) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/common/IsDownloadLanguage?languageid=$languageId&syncdate=$syncDate");
    return DownloadLanguageModel.fromJson(response);
  }
}
