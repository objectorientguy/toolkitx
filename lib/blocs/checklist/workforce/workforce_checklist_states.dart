import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/checklist/workforce/submit_questions.dart';

import '../../../data/models/checklist/workforce/list_model.dart';
import '../../../data/models/checklist/workforce/questions_comments_model.dart';
import '../../../data/models/checklist/workforce/questions_list_model.dart';
import '../../../data/models/checklist/workforce/reject_reasons_model.dart';
import '../../../data/models/checklist/workforce/save_questions_comments.dart';
import '../../../data/models/checklist/workforce/save_reject_reasons.dart';

abstract class WorkforceChecklistStates extends Equatable {}

class ChecklistInitial extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingChecklist extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistFetched extends WorkforceChecklistStates {
  final WorkforceGetCheckListModel getCheckListModel;

  ChecklistFetched({required this.getCheckListModel});

  @override
  List<Object?> get props => [];
}

class FetchChecklistError extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingRejectReasons extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RejectReasonsFetched extends WorkforceChecklistStates {
  final GetCheckListRejectReasonsModel getCheckListRejectReasonsModel;
  final String reason;

  RejectReasonsFetched(
      {required this.reason, required this.getCheckListRejectReasonsModel});

  @override
  List<Object?> get props => [reason, getCheckListRejectReasonsModel];
}

class RejectReasonsError extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SelectReasonsError extends WorkforceChecklistStates {
  final String reason;

  SelectReasonsError({required this.reason});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingQuestions extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class QuestionsFetched extends WorkforceChecklistStates {
  final GetQuestionListModel getQuestionListModel;
  final List answerList;
  final Map allChecklistDataMap;

  QuestionsFetched(
      {required this.allChecklistDataMap,
      required this.answerList,
      required this.getQuestionListModel});

  @override
  List<Object?> get props => [answerList, getQuestionListModel];
}

class QuestionsError extends WorkforceChecklistStates {
  final Map allChecklistDataMap;

  QuestionsError({required this.allChecklistDataMap});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class WfPopUpMenuItemsFetched extends WorkforceChecklistStates {
  final List popUpMenuItems;
  final Map allChecklistDataMap;

  WfPopUpMenuItemsFetched(
      {required this.allChecklistDataMap, required this.popUpMenuItems});

  @override
  List<Object?> get props => [allChecklistDataMap, popUpMenuItems];
}

class SavingRejectReasons extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RejectReasonsSaved extends WorkforceChecklistStates {
  final PostRejectReasonsModel postRejectReasonsModel;

  RejectReasonsSaved({required this.postRejectReasonsModel});

  @override
  List<Object?> get props => [postRejectReasonsModel];
}

class RejectReasonsNotSaved extends WorkforceChecklistStates {
  final String message;

  RejectReasonsNotSaved({required this.message});

  @override
  List<Object?> get props => [message];
}

class FetchingQuestionComments extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class QuestionCommentsFetched extends WorkforceChecklistStates {
  final GetQuestionCommentsModel getQuestionCommentsModel;

  QuestionCommentsFetched({required this.getQuestionCommentsModel});

  @override
  List<Object?> get props => [getQuestionCommentsModel];
}

class QuestionCommentsError extends WorkforceChecklistStates {
  final String quesResponseId;

  QuestionCommentsError({required this.quesResponseId});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SavingQuestionComments extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class QuestionCommentsSaved extends WorkforceChecklistStates {
  final SaveQuestionCommentsModel saveQuestionCommentsModel;

  QuestionCommentsSaved({required this.saveQuestionCommentsModel});

  @override
  List<Object?> get props => [saveQuestionCommentsModel];
}

class QuestionCommentsNotSaved extends WorkforceChecklistStates {
  final String message;

  QuestionCommentsNotSaved({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SubmittingQuestion extends WorkforceChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class QuestionSubmitted extends WorkforceChecklistStates {
  final SubmitQuestionModel submitQuestionModel;

  QuestionSubmitted({required this.submitQuestionModel});

  @override
  List<Object?> get props => [submitQuestionModel];
}

class QuestionNotSubmitted extends WorkforceChecklistStates {
  final String message;

  QuestionNotSubmitted({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SavedQuestions extends WorkforceChecklistStates {
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

class QuestionsEdited extends WorkforceChecklistStates {
  final String? dropDownValue;
  final List multiSelect;
  final String? radioValue;

  QuestionsEdited(
      {this.radioValue, required this.multiSelect, this.dropDownValue});

  @override
  List<Object?> get props => [dropDownValue, multiSelect, radioValue];
}
