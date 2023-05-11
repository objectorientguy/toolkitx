import 'package:toolkit/utils/constants/api_constants.dart';
import '../../data/models/select_your_language_model.dart';
import '../../utils/dio_client.dart';
import 'select_language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  @override
  Future<LanguageModel> fetchLanguages() async {
    final response =
        await DioClient().get("${ApiConstants.baseUrl}common/getlanguages");
    return LanguageModel.fromJson(response);
  }
}
