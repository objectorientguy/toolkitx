abstract class LanguageEvent {}

class FetchLanguages extends LanguageEvent {}

class FetchLanguageKeys extends LanguageEvent {
  final int languageId;

  FetchLanguageKeys({required this.languageId});
}

class CheckNewLanguageKeys extends LanguageEvent {
  final int languageId;

  CheckNewLanguageKeys({required this.languageId});
}
