import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/data/models/select_your_language_model.dart';

import '../../repositories/selectLanguage/select_language_repository.dart';
import 'select_language_events.dart';
import 'select_language_states.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageStates> {
  final LanguageRepository _languageRepository = getIt<LanguageRepository>();

  LanguageStates get initialState => LanguageInitial();

  LanguageBloc() : super(LanguageInitial()) {
    on<FetchLanguageEvent>(_fetchLanguage);
  }

  FutureOr<void> _fetchLanguage(
      FetchLanguageEvent event, Emitter<LanguageStates> emit) async {
    emit(LanguagesLoading());
    try {
      LanguageModel languageModel = await _languageRepository.fetchLanguages();
      emit(LanguagesLoaded(languageModel: languageModel));
    } catch (e) {
      emit(LanguagesError(message: e.toString()));
    }
  }
}
