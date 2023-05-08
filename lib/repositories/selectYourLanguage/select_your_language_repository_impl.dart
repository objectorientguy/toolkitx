import '../../data/models/select_your_language_model.dart';
import '../../utils/constants/api_constants.dart';
import 'select_your_language_repository.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  final ApiProvider apiProvider;

  LanguageRepositoryImpl({required this.apiProvider});

  @override
  Future<LanguageModel> fetchLanguages() async {
    final response = await apiProvider
        .get("http://breeders.software/api/api/common/getlanguages");
    return LanguageModel.fromJson(response);
  }
}
