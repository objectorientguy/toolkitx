import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/checklist/workforce/list_model.dart';
import 'package:toolkit/data/models/checklist/workforce/reject_reasons_model.dart';
import 'package:toolkit/data/models/checklist/workforce/submit_questions.dart';
import 'package:toolkit/repositories/checklist/workforce/workforce_repository.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/checklist/workforce/questions_comments_model.dart';
import '../../../data/models/checklist/workforce/questions_list_model.dart';
import '../../../data/models/checklist/workforce/save_questions_comments.dart';
import '../../../data/models/checklist/workforce/save_reject_reasons.dart';
import 'workforce_checklist_events.dart';
import 'workforce_checklist_states.dart';

class WorkforceChecklistBloc
    extends Bloc<WorkforceCheckListEvents, WorkforceChecklistStates> {
  final WorkforceChecklistRepository _workforceChecklistRepository =
      getIt<WorkforceChecklistRepository>();
  Map allDataForChecklistMap = {};
  List answerList = [];
  List<Questionlist>? questionList;
  List submitList = [];

  WorkforceChecklistStates get initialState => ChecklistInitial();

  WorkforceChecklistBloc() : super(ChecklistInitial()) {
    on<FetchChecklist>(_fetchChecklist);
    on<FetchRejectReasons>(_fetchChecklistRejectReason);
    on<SelectRejectReasons>(_selectRejectReason);
    on<FetchQuestions>(_fetchQuestions);
    on<FetchPopUpMenuItems>(_fetchPopUpMenuItems);
    on<SaveRejectReasons>(_saveRejectReasons);
    on<FetchQuestionComment>(_fetchQuestionComments);
    on<SaveQuestionComment>(_saveQuestionComments);
    on<SubmitQuestions>(_submitQuestions);
    on<EditQuestionData>(_editQuestionsData);
    on<EditQuestions>(_editQuestions);
  }

  FutureOr<void> _fetchChecklist(
      FetchChecklist event, Emitter<WorkforceChecklistStates> emit) async {
    emit(FetchingChecklist());
    try {
      WorkforceGetCheckListModel workforceGetCheckListModel =
          await _workforceChecklistRepository.fetchChecklist();
      emit(ChecklistFetched(getCheckListModel: workforceGetCheckListModel));
    } catch (e) {
      emit(FetchChecklistError());
    }
  }

  FutureOr<void> _fetchChecklistRejectReason(
      FetchRejectReasons event, Emitter<WorkforceChecklistStates> emit) async {
    emit(FetchingRejectReasons());
    try {
      GetCheckListRejectReasonsModel getCheckListRejectReasonsModel =
          await _workforceChecklistRepository.fetchChecklistRejectReason();
      if (getCheckListRejectReasonsModel.status == 200 &&
          getCheckListRejectReasonsModel.data!.isNotEmpty) {
        add(SelectRejectReasons(
            reason: '',
            getCheckListRejectReasonsModel: getCheckListRejectReasonsModel));
      } else {
        emit(RejectReasonsError());
      }
    } catch (e) {
      emit(RejectReasonsError());
    }
  }

  _selectRejectReason(
      SelectRejectReasons event, Emitter<WorkforceChecklistStates> emit) async {
    emit(RejectReasonsFetched(
        getCheckListRejectReasonsModel: event.getCheckListRejectReasonsModel,
        reason: event.reason));
  }

  FutureOr<void> _fetchQuestions(
      FetchQuestions event, Emitter<WorkforceChecklistStates> emit) async {
    emit(FetchingQuestions());
    answerList.clear();
    try {
      allDataForChecklistMap = event.checklistData;
      String answerText = '';
      GetQuestionListModel getQuestionListModel =
          await _workforceChecklistRepository.fetchChecklistQuestions(
              event.checklistData["scheduleId"], event.checklistData["userId"]);
      if (getQuestionListModel.status == 200) {
        questionList = getQuestionListModel.data!.questionlist;
        for (int i = 0;
            i < getQuestionListModel.data!.questionlist!.length;
            i++) {
          if (getQuestionListModel.data!.questionlist![i].optioncomment !=
                  null &&
              getQuestionListModel.data!.questionlist![i].optioncomment.length >
                  0) {
            answerText = getQuestionListModel
                .data!.questionlist![i].optioncomment
                .toString();
            log("answer text 1=======>$answerText");
          } else if (getQuestionListModel.data!.questionlist![i].optionid !=
              null) {
            answerText = getQuestionListModel.data!.questionlist![i].optiontext
                .toString();
            log("answer text 2=======>$answerText");
          }
          answerList.add({
            "questionid": getQuestionListModel.data!.questionlist![i].id,
            "answer": answerText
          });
        }
        emit(QuestionsFetched(
            getQuestionListModel: getQuestionListModel,
            answerList: answerList,
            allChecklistDataMap: allDataForChecklistMap));
      }
    } catch (e) {
      emit(QuestionsError(allChecklistDataMap: allDataForChecklistMap));
    }
  }

  _fetchPopUpMenuItems(
      FetchPopUpMenuItems event, Emitter<WorkforceChecklistStates> emit) {
    List popUpMenuItems = ['Edit', 'Reject'];
    emit(WfPopUpMenuItemsFetched(
        popUpMenuItems: popUpMenuItems,
        allChecklistDataMap: allDataForChecklistMap));
  }

  FutureOr<void> _saveRejectReasons(
      SaveRejectReasons event, Emitter<WorkforceChecklistStates> emit) async {
    emit(SavingRejectReasons());
    try {
      if (event.reason == "null" || event.reason.trim().isEmpty) {
        emit(RejectReasonsNotSaved(message: 'Please select a reason!'));
      } else {
        Map saveRejectReasonMap = {
          "scheduleid": allDataForChecklistMap["scheduleId"],
          "workforceid": allDataForChecklistMap["userId"],
          "reasontext": event.reason,
          "hashcode":
              '9i2CF+lFcvH59NOsOTI9b2POWg0nKle29CpuaapAGRJGICrBkG7OH4mA2ip4z1yY|3|2|1|ist_42'
        };
        PostRejectReasonsModel postRejectReasonsModel =
            await _workforceChecklistRepository
                .saveRejectReasons(saveRejectReasonMap);
        emit(
            RejectReasonsSaved(postRejectReasonsModel: postRejectReasonsModel));
      }
    } catch (e) {
      emit(RejectReasonsNotSaved(message: e.toString()));
    }
  }

  FutureOr<void> _fetchQuestionComments(FetchQuestionComment event,
      Emitter<WorkforceChecklistStates> emit) async {
    emit(FetchingQuestionComments());
    try {
      allDataForChecklistMap["questionResponseId"] = event.questionResponseId;
      GetQuestionCommentsModel getQuestionCommentsModel =
          await _workforceChecklistRepository.fetchQuestionsComments(
              allDataForChecklistMap["questionResponseId"]);
      emit(QuestionCommentsFetched(
          getQuestionCommentsModel: getQuestionCommentsModel));
    } catch (e) {
      emit(QuestionCommentsError(
          quesResponseId: allDataForChecklistMap["questionResponseId"]));
    }
  }

  FutureOr<void> _saveQuestionComments(
      SaveQuestionComment event, Emitter<WorkforceChecklistStates> emit) async {
    emit(SavingQuestionComments());
    try {
      if (event.saveQuestionCommentMap["comments"] == null ||
          event.saveQuestionCommentMap["comments"].toString().trim().isEmpty) {
        emit(QuestionCommentsNotSaved(message: 'Please enter comment!'));
      } else {
        Map saveQuestionCommentMap = {
          "id": allDataForChecklistMap["userId"],
          "queresponseid": allDataForChecklistMap["questionResponseId"],
          "comments": event.saveQuestionCommentMap["comments"],
          "filenames": '',
          "hashcode":
              '9i2CF+lFcvH59NOsOTI9b2POWg0nKle29CpuaapAGRJGICrBkG7OH4mA2ip4z1yY|3|2|1|ist_42'
        };
        SaveQuestionCommentsModel saveQuestionCommentsModel =
            await _workforceChecklistRepository
                .saveQuestionsComments(saveQuestionCommentMap);
        emit(QuestionCommentsSaved(
            saveQuestionCommentsModel: saveQuestionCommentsModel));
      }
    } catch (e) {
      emit(QuestionCommentsNotSaved(message: e.toString()));
    }
  }

  FutureOr<void> _submitQuestions(
      SubmitQuestions event, Emitter<WorkforceChecklistStates> emit) async {
    emit(SubmittingQuestion());
    try {
      log("event edit questions list=====>${event.editQuestionsList}");
      log("draftt=========>${event.isDraft}");
      submitList = [];
      String id = '';
      String answer = '';
      for (int j = 0; j < event.editQuestionsList.length; j++) {
        id = event.editQuestionsList[j]["questionid"];
        answer = event.editQuestionsList[j]["answer"];
        log("id=====>$id");
        log("answer====>$answer");
        submitList.add({"questionid": id, "answer": answer});
      }
      log("submit list======>$submitList");
      Map submitQuestionMap = {
        "checklistid": allDataForChecklistMap["checklistId"],
        "workforceid": allDataForChecklistMap["userId"],
        "isdraft": (event.isDraft == true) ? "1" : "",
        "questions": submitList,
        "scheduleid": allDataForChecklistMap["scheduleId"],
        "hashcode":
            '9i2CF+lFcvH59NOsOTI9b2POWg0nKle29CpuaapAGRJGICrBkG7OH4mA2ip4z1yY|3|2|1|ist_42'
      };
      SubmitQuestionModel submitQuestionModel =
          await _workforceChecklistRepository
              .submitQuestions(submitQuestionMap);
      emit(QuestionSubmitted(submitQuestionModel: submitQuestionModel));
    } catch (e) {
      emit(QuestionNotSubmitted(message: e.toString()));
    }
  }

  _editQuestionsData(
      EditQuestionData event, Emitter<WorkforceChecklistStates> emit) async {
    add(EditQuestions(
        dropDownValue: '',
        multiSelectList: [],
        multiSelectItem: '',
        multiSelectName: ''));
    emit(SavedQuestions(
      answerModelList: questionList!,
      allChecklistDataMap: allDataForChecklistMap,
      saveDraft: '',
      answersList: answerList,
    ));
  }

  _editQuestions(EditQuestions event, Emitter<WorkforceChecklistStates> emit) {
    List multiSelectList = List.from(event.multiSelectList);
    if (event.multiSelectItem.isNotEmpty && event.multiSelectList != []) {
      if (event.multiSelectList.contains(event.multiSelectItem) != true) {
        multiSelectList.add(event.multiSelectItem);
      } else {
        multiSelectList.remove(event.multiSelectItem);
      }
    }
    emit(QuestionsEdited(
        dropDownValue: event.dropDownValue,
        multiSelect: multiSelectList,
        radioValue: event.radioValue));
  }
}
