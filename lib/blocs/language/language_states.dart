import 'package:toolkit/data/models/language/dowanload_language.dart';
import 'package:toolkit/data/models/language/get_language_keys.dart';

import '../../data/models/language/get_languages_model.dart';

abstract class LanguageStates {}

class LanguageInitial extends LanguageStates {}

class LanguagesLoading extends LanguageStates {}

class LanguagesLoaded extends LanguageStates {
  final GetLanguagesModel getLanguagesModel;

  LanguagesLoaded({required this.getLanguagesModel});
}

class LanguagesError extends LanguageStates {
  final String message;

  LanguagesError({required this.message});
}

class DownLoadLanguageLoading extends LanguageStates {}

class DownLoadLanguageLoaded extends LanguageStates {
  final DownloadLanguageModel downloadLanguageModel;

  DownLoadLanguageLoaded({required this.downloadLanguageModel});
}

class DownLoadLanguageError extends LanguageStates {
  final String message;

  DownLoadLanguageError({required this.message});
}

class LanguageKeysLoading extends LanguageStates {}

class LanguageKeysLoaded extends LanguageStates {
  final GetLanguageKeysModel getLanguageKeysModel;

  LanguageKeysLoaded({required this.getLanguageKeysModel});
}

class LanguageKeysError extends LanguageStates {
  final String message;

  LanguageKeysError({required this.message});
}
