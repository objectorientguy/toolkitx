import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/data/cache/customer_cache.dart';

import '../repositories/selectLanguage/select_language_repository.dart';
import '../repositories/selectLanguage/select_language_repository_impl.dart';
import '../repositories/systemUser/checklist/repository.dart';
import '../repositories/systemUser/checklist/repository_impl.dart';

final getIt = GetIt.instance;

configurableDependencies() {
  getIt.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  getIt.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl());
  getIt.registerLazySingleton<CustomerCache>(
      () => CustomerCache(sharedPreferences: getIt<SharedPreferences>()));
  getIt.registerLazySingleton<ChecklistRepository>(
      () => ChecklistRepositoryImpl());
}
