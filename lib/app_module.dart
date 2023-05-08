import 'package:get_it/get_it.dart';
import 'repositories/selectYourLanguage/select_your_language_repository.dart';
import 'repositories/selectYourLanguage/select_your_language_repository_impl.dart';
import 'utils/constants/api_constants.dart';

final getIt = GetIt.instance;

configurableDependencies() {
  getIt.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(apiProvider: ApiProvider()));
}
