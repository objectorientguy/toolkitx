import '../../../data/models/workforce/workforce_questions_list_model.dart';

abstract class WorkForceQuestionsStates {}

class FetchQuestionsListInitial extends WorkForceQuestionsStates {}

class FetchingQuestionsList extends WorkForceQuestionsStates {}

class QuestionsListFetched extends WorkForceQuestionsStates {
  final GetQuestionListModel getQuestionListModel;
  final List answerList;
  final Map allChecklistDataMap;

  QuestionsListFetched(
      {required this.getQuestionListModel,
      required this.allChecklistDataMap,
      required this.answerList});
}

class QuestionsListNotFetched extends WorkForceQuestionsStates {
  final Map allChecklistDataMap;

  QuestionsListNotFetched({required this.allChecklistDataMap});
}
