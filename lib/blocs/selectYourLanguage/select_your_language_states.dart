import '../../data/models/select_your_language_model.dart';

abstract class LanguageStates {}

class LanguageInitial extends LanguageStates {}

class LanguagesLoading extends LanguageStates {}

class LanguagesLoaded extends LanguageStates {
  final LanguageModel languageModel;

  LanguagesLoaded({required this.languageModel});
}

class LanguagesError extends LanguageStates {
  final String message;

  LanguagesError({required this.message});
}
