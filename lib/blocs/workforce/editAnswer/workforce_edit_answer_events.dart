import '../../../data/models/workforce/workforce_questions_list_model.dart';

abstract class EditAnswer {}

class PopulateAnswerData extends EditAnswer {
  final List<Questionlist> questionList;
  final String? multiSelect;
  final String? dropDownValue;
  final List answerList;
  final Map allChecklistDataMap;

  PopulateAnswerData(
      {required this.allChecklistDataMap,
      required this.answerList,
      required this.dropDownValue,
      required this.multiSelect,
      required this.questionList});
}

class EditAnswerEvent extends EditAnswer {
  final String? dropDownValue;
  final List multiSelectIdList;
  final String multiSelectItem;
  final String? radioValue;
  final String multiSelectName;
  final List multiSelectNameList;

  EditAnswerEvent(
      {required this.multiSelectNameList,
      required this.multiSelectName,
      this.radioValue = '',
      required this.multiSelectItem,
      required this.multiSelectIdList,
      this.dropDownValue = ''});
}
