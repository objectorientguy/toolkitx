import 'package:equatable/equatable.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';

abstract class WorkForceCheckListEditAnswerStates extends Equatable {}

class CheckListEditAnswerInitial extends WorkForceCheckListEditAnswerStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SavedCheckListQuestions extends WorkForceCheckListEditAnswerStates {
  final List<Questionlist> answerModelList;
  final Map allChecklistDataMap;
  final String saveDraft;
  final List answersList;

  SavedCheckListQuestions(
      {required this.answersList,
      required this.saveDraft,
      required this.allChecklistDataMap,
      required this.answerModelList});

  @override
  List<Object?> get props => [answerModelList];
}

class CheckListAnswersEdited extends WorkForceCheckListEditAnswerStates {
  final String? dropDownValue;
  final List multiSelectId;
  final String? radioValue;
  final List multiSelectNames;

  CheckListAnswersEdited(
      {required this.multiSelectNames,
      this.radioValue,
      required this.multiSelectId,
      this.dropDownValue});

  @override
  List<Object?> get props => [dropDownValue, multiSelectId, radioValue];
}

class CheckListTableControlEdit extends WorkForceCheckListEditAnswerStates {
  final bool isEdit;

  CheckListTableControlEdit({required this.isEdit});

  @override
  List<Object?> get props => [isEdit];
}
