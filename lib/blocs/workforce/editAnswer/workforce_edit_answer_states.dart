import 'package:equatable/equatable.dart';

import '../../../data/models/workforce/workforce_questions_list_model.dart';

abstract class EditAnswerStates extends Equatable {}

class EditAnswerInitial extends EditAnswerStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SavedQuestions extends EditAnswerStates {
  final List<Questionlist> answerModelList;
  final Map allChecklistDataMap;
  final String saveDraft;
  final List answersList;

  SavedQuestions(
      {required this.answersList,
      required this.saveDraft,
      required this.allChecklistDataMap,
      required this.answerModelList});

  @override
  List<Object?> get props => [answerModelList];
}

class AnswersEdited extends EditAnswerStates {
  final String? dropDownValue;
  final List multiSelectId;
  final String? radioValue;
  final List multiSelectNames;

  AnswersEdited(
      {required this.multiSelectNames,
      this.radioValue,
      required this.multiSelectId,
      this.dropDownValue});

  @override
  List<Object?> get props => [dropDownValue, multiSelectId, radioValue];
}
