abstract class WorkForceQuestionsList {}

class FetchQuestions extends WorkForceQuestionsList {
  final Map checklistData;

  FetchQuestions({required this.checklistData});
}
