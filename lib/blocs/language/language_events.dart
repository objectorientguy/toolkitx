abstract class LanguageEvent {}

class FetchLanguages extends LanguageEvent {}

class FetchLanguageKeys extends LanguageEvent {
  final int languageId;

  FetchLanguageKeys({required this.languageId});
}

class DownloadLanguage extends LanguageEvent {
  final int languageId;

  DownloadLanguage({required this.languageId});
}
