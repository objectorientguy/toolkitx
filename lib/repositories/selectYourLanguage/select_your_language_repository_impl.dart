import '../../data/models/select_your_language_model.dart';
import '../../utils/dio_client.dart';
import 'select_your_language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  DioClient dio = DioClient();

  LanguageRepositoryImpl({required this.dio});

  @override
  Future<LanguageModel> fetchLanguages() async {
    final dynamic response = await dio.get("${dio.baseUrl}common/getlanguages");
    return LanguageModel.fromJson(response);
  }
}
