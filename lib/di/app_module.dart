import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/data/models/permit/all_permits_model.dart';
import 'package:toolkit/repositories/incident/incident_repository.dart';
import 'package:toolkit/repositories/incident/incident_repository_impl.dart';
import 'package:toolkit/repositories/login/login_repository_impl.dart';
import 'package:toolkit/repositories/profile/profile_repository_impl.dart';

import '../repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import '../repositories/checklist/systemUser/sys_user_checklist_repository_impl.dart';
import '../repositories/checklist/workforce/workforce_repository.dart';
import '../repositories/checklist/workforce/workforce_repository_impl.dart';
import '../repositories/permit/permit_repository.dart';
import '../repositories/permit/permit_repository_impl.dart';
import '../data/cache/customer_cache.dart';
import '../repositories/client/client_repository.dart';
import '../repositories/client/client_repository_impl.dart';
import '../repositories/language/language_repository.dart';
import '../repositories/language/language_repository_impl.dart';
import '../repositories/login/login_repository.dart';
import '../repositories/profile/profile_repository.dart';
import '../repositories/timeZone/time_zone_repository.dart';
import '../repositories/timeZone/time_zone_repository_impl.dart';
import '../repositories/uploadImage/upload_image_repository.dart';
import '../repositories/uploadImage/upload_image_repository_impl.dart';

final getIt = GetIt.instance;

configurableDependencies() {
  getIt.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  getIt.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl());
  getIt.registerLazySingleton<PermitRepository>(() => PermitRepositoryImpl());
  getIt.registerLazySingleton<AllPermitDatum>(() => AllPermitDatum());
  getIt.registerLazySingleton<CustomerCache>(
      () => CustomerCache(sharedPreferences: getIt<SharedPreferences>()));
  getIt.registerLazySingleton<TimeZoneRepository>(
      () => TimeZoneRepositoryImpl());
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());
  getIt.registerLazySingleton<WorkForceRepository>(
      () => WorkforceChecklistRepositoryImpl());
  getIt.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  getIt.registerLazySingleton<SysUserCheckListRepository>(
      () => SysUserCheckListRepositoryImpl());
  getIt.registerLazySingleton<UploadImageRepository>(
      () => UploadImageRepositoryImpl());
  getIt.registerLazySingleton<IncidentRepository>(
      () => IncidentRepositoryImpl());
}
