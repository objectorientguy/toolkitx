import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/repositories/checklist/workforce/workforce_repository.dart';
import 'package:toolkit/repositories/checklist/workforce/workforce_repositpry_impl.dart';
import 'package:toolkit/data/models/permit/all_permits_model.dart';
import 'package:toolkit/repositories/login/login_repository_impl.dart';
import 'package:toolkit/repositories/profile/profile_repository_impl.dart';
import 'package:toolkit/repositories/uploadPicture/upload_picture_repository_impl.dart';

import '../repositories/checklist/systemUser/sys_user_checklist_repo.dart';
import '../repositories/checklist/systemUser/sys_user_checklist_repo_impl.dart';
import '../repositories/checklist/systemUser/system_user_repository.dart';
import '../repositories/checklist/systemUser/system_user_repository_impl.dart';
import '../repositories/permit/permit_repository.dart';
import '../repositories/permit/permit_repository_impl.dart';
import '../repositories/client/client_repository.dart';
import '../repositories/client/client_repository_impl.dart';
import '../repositories/language/language_repository.dart';
import '../repositories/language/language_repository_impl.dart';
import '../repositories/login/login_repository.dart';
import '../repositories/profile/profile_repository.dart';
import '../repositories/timeZone/time_zone_repository.dart';
import '../repositories/timeZone/time_zone_repository_impl.dart';
import '../repositories/uploadPicture/upload_picture_repository.dart';

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
  getIt.registerLazySingleton<ChecklistRepository>(
      () => ChecklistRepositoryImpl());
  getIt.registerLazySingleton<CheckListRepository>(
      () => CheckListRepositoryImpl());
  getIt.registerLazySingleton<WorkforceChecklistRepository>(
      () => WorkforceChecklistRepositoryImpl());
  getIt.registerLazySingleton<UploadImageRepository>(
      () => UploadImageRepositoryImpl());
  getIt.registerLazySingleton<TimeZoneRepository>(
      () => TimeZoneRepositoryImpl());
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());
  getIt.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
}
