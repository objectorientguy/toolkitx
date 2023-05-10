import 'package:get_it/get_it.dart';
import 'package:toolkit/utils/dio_client.dart';

import '../repositories/selectYourLanguage/select_your_language_repository.dart';
import '../repositories/selectYourLanguage/select_your_language_repository_impl.dart';

final getIt = GetIt.instance;

configurableDependencies() {
  getIt.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(dio: DioClient()));
}
