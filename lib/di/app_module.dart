import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/repositories/checklist/workforce/repository.dart';
import 'package:toolkit/repositories/checklist/workforce/repositpry_impl.dart';

import '../repositories/checklist/systemUser/repository.dart';
import '../repositories/checklist/systemUser/repository_impl.dart';
import '../repositories/selectLanguage/select_language_repository.dart';
import '../repositories/selectLanguage/select_language_repository_impl.dart';

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
  getIt.registerLazySingleton<WorkforceChecklistRepository>(
      () => WorkforceChecklistRepositoryImpl());
}
