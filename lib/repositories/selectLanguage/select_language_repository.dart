import 'package:toolkit/data/models/select_your_language_model.dart';

abstract class LanguageRepository {
  Future<LanguageModel> fetchLanguages();
}
