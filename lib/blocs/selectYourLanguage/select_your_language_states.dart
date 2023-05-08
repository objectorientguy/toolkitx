import 'package:equatable/equatable.dart';

import '../../data/models/select_your_language_model.dart';

abstract class LanguageStates extends Equatable {}

class LanguageInitial extends LanguageStates {
  @override
  List<Object?> get props => [];
}

class FetchLanguageLoading extends LanguageStates {
  @override
  List<Object?> get props => [];
}

class FetchLanguageLoaded extends LanguageStates {
  final LanguageModel languageModel;

  FetchLanguageLoaded({required this.languageModel});

  @override
  List<Object?> get props => [];
}

class FetchLanguageError extends LanguageStates {
  final String message;

  FetchLanguageError({required this.message});

  @override
  List<Object?> get props => [];
}
