import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workforce/editAnswer/workforce_edit_answer_events.dart';
import 'package:toolkit/blocs/workforce/editAnswer/workforce_edit_answer_states.dart';

class EditAnswerBloc extends Bloc<EditAnswer, EditAnswerStates> {
  Map allDataForChecklistMap = {};

  EditAnswerBloc() : super(EditAnswerInitial()) {
    on<PopulateAnswerData>(_populateAnswerData);
    on<EditAnswerEvent>(_editAnswer);
  }

  _populateAnswerData(
      PopulateAnswerData event, Emitter<EditAnswerStates> emit) {
    add(EditAnswerEvent(
        dropDownValue: '',
        multiSelectIdList: [],
        multiSelectItem: '',
        multiSelectName: '',
        multiSelectNameList: []));
    emit(SavedQuestions(
        answerModelList: event.questionList,
        allChecklistDataMap: event.allChecklistDataMap,
        saveDraft: '',
        answersList: event.answerList));
  }

  _editAnswer(EditAnswerEvent event, Emitter<EditAnswerStates> emit) {
    List multiSelectList = List.from(event.multiSelectIdList);
    List multiSelectNames = List.from(event.multiSelectNameList);
    if (event.multiSelectItem.isNotEmpty && event.multiSelectIdList != []) {
      if (event.multiSelectIdList.contains(event.multiSelectItem) != true) {
        multiSelectList.add(event.multiSelectItem);
        multiSelectNames.add(event.multiSelectName);
      } else {
        multiSelectList.remove(event.multiSelectItem);
        multiSelectNames.remove(event.multiSelectName);
      }
    }
    emit(AnswersEdited(
        dropDownValue: event.dropDownValue,
        multiSelectId: multiSelectList,
        radioValue: event.radioValue,
        multiSelectNames: multiSelectNames));
  }
}
