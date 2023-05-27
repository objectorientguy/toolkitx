import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/language/dowanload_language.dart';
import 'package:toolkit/data/models/language/get_language_keys.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/data/models/language/get_languages_model.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../data/cache/customer_cache.dart';
import '../../repositories/language/language_repository.dart';
import 'language_events.dart';
import 'language_states.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageStates> {
  final LanguageRepository _languageRepository = getIt<LanguageRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LanguageStates get initialState => LanguageInitial();

  LanguageBloc() : super(LanguageInitial()) {
    on<FetchLanguages>(_fetchLanguages);
    on<FetchLanguageKeys>(_fetchLanguageKeys);
    on<DownloadLanguage>(_downloadLanguage);
  }

  FutureOr<void> _fetchLanguages(
      FetchLanguages event, Emitter<LanguageStates> emit) async {
    emit(LanguagesLoading());
    try {
      GetLanguagesModel getLanguagesModel =
          await _languageRepository.fetchLanguages();
      emit(LanguagesLoaded(getLanguagesModel: getLanguagesModel));
    } catch (e) {
      emit(LanguagesError(message: e.toString()));
    }
  }

  FutureOr<void> _fetchLanguageKeys(
      FetchLanguageKeys event, Emitter<LanguageStates> emit) async {
    emit(LanguageKeysLoading());
    try {
      String syncDate;
      try {
        syncDate = (await _customerCache
            .getLanguageSyncDate(CacheKeys.languageSyncDate))!;
      } catch (e) {
        syncDate = '';
      }
      GetLanguageKeysModel getLanguageKeysModel = await _languageRepository
          .fetchLanguageKeys(event.languageId, syncDate, -1);

      if (getLanguageKeysModel.status == 200) {
        for (var element in getLanguageKeysModel.data!.keys) {
          DatabaseUtil.box.put(element.key, element.value);
        }
      }
      emit(LanguageKeysLoaded(getLanguageKeysModel: getLanguageKeysModel));
    } catch (e) {
      emit(LanguageKeysError(message: e.toString()));
    }
  }

  FutureOr<void> _downloadLanguage(
      DownloadLanguage event, Emitter<LanguageStates> emit) async {
    emit(DownLoadLanguageLoading());
    try {
      String syncDate;
      try {
        syncDate = (await _customerCache
            .getLanguageSyncDate(CacheKeys.languageSyncDate))!;
      } catch (e) {
        syncDate = '';
      }
      DownloadLanguageModel downloadLanguageModel = await _languageRepository
          .isDownloadLanguage(event.languageId, syncDate);
      emit(
          DownLoadLanguageLoaded(downloadLanguageModel: downloadLanguageModel));
    } catch (e) {
      emit(DownLoadLanguageError(message: e.toString()));
    }
  }
}
