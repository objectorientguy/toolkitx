import '../../../data/models/checklist/workforce/questions_list_model.dart';
import '../../../data/models/checklist/workforce/reject_reasons_model.dart';

abstract class WorkforceCheckListEvents {}

class FetchChecklist extends WorkforceCheckListEvents {
  final String userId;

  FetchChecklist({required this.userId});
}

class FetchRejectReasons extends WorkforceCheckListEvents {}

class SelectRejectReasons extends WorkforceCheckListEvents {
  final GetCheckListRejectReasonsModel getCheckListRejectReasonsModel;
  final String reason;

  SelectRejectReasons(
      {required this.getCheckListRejectReasonsModel, required this.reason});
}

class FetchQuestions extends WorkforceCheckListEvents {
  final Map checklistData;

  FetchQuestions({
    required this.checklistData,
  });
}

class FetchPopUpMenuItems extends WorkforceCheckListEvents {
  final List popUpMenuItems;

  FetchPopUpMenuItems({required this.popUpMenuItems});
}

class SaveRejectReasons extends WorkforceCheckListEvents {
  final String reason;

  SaveRejectReasons({required this.reason});
}

class FetchQuestionComment extends WorkforceCheckListEvents {
  final String questionResponseId;

  FetchQuestionComment({required this.questionResponseId});
}

class SaveQuestionComment extends WorkforceCheckListEvents {
  final Map saveQuestionCommentMap;

  SaveQuestionComment({required this.saveQuestionCommentMap});
}

class SubmitQuestions extends WorkforceCheckListEvents {
  final List submitQuestionsList;
  final List editQuestionsList;

  SubmitQuestions(
      {required this.editQuestionsList, required this.submitQuestionsList});
}

class PopulateQuestion extends WorkforceCheckListEvents {
  final List<Questionlist> questionList;
  final List? populateQuestionsList;
  final String? multiSelect;
  final String? dropDownValue;

  PopulateQuestion(
      {required this.dropDownValue,
      required this.multiSelect,
      required this.questionList,
      required this.populateQuestionsList});
}

class EditQuestions extends WorkforceCheckListEvents {
  final List editQuestionsList;

  EditQuestions({required this.editQuestionsList});
}
