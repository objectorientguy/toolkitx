import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/repositories/login/login_repository_impl.dart';
import 'package:toolkit/repositories/profile/profile_repository_impl.dart';

import '../data/cache/customer_cache.dart';
import '../repositories/client/client_repository.dart';
import '../repositories/client/client_repository_impl.dart';
import '../repositories/language/language_repository.dart';
import '../repositories/language/language_repository_impl.dart';
import '../repositories/login/login_repository.dart';
import '../repositories/profile/profile_repository.dart';
import '../repositories/timeZone/time_zone_repository.dart';
import '../repositories/timeZone/time_zone_repository_impl.dart';

final getIt = GetIt.instance;

configurableDependencies() {
  getIt.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  getIt.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl());
  getIt.registerLazySingleton<CustomerCache>(
      () => CustomerCache(sharedPreferences: getIt<SharedPreferences>()));
  getIt.registerLazySingleton<TimeZoneRepository>(
      () => TimeZoneRepositoryImpl());
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());

  getIt.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
}
