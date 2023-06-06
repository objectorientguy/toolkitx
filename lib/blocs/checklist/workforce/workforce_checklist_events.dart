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
  final List editQuestionsList;
  final String draft;
  final bool isDraft;

  SubmitQuestions(
      {required this.isDraft,
      required this.draft,
      required this.editQuestionsList});
}

class EditQuestionData extends WorkforceCheckListEvents {
  final List<Questionlist> questionList;
  final String? multiSelect;
  final String? dropDownValue;

  EditQuestionData(
      {required this.dropDownValue,
      required this.multiSelect,
      required this.questionList});
}

class EditQuestions extends WorkforceCheckListEvents {
  final String? dropDownValue;
  final List multiSelectList;
  final String multiSelectItem;
  final String? radioValue;
  final String multiSelectName;

  EditQuestions(
      {required this.multiSelectName,
      this.radioValue = '',
      required this.multiSelectItem,
      required this.multiSelectList,
      this.dropDownValue = ''});
}
