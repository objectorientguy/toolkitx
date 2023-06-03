import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/checklist/workforce/list_model.dart';
import 'package:toolkit/data/models/checklist/workforce/reject_reasons_model.dart';
import 'package:toolkit/data/models/checklist/workforce/submit_questions.dart';
import 'package:toolkit/repositories/checklist/workforce/repository.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/checklist/workforce/questions_comments_model.dart';
import '../../../data/models/checklist/workforce/questions_list_model.dart';
import '../../../data/models/checklist/workforce/save_questions_comments.dart';
import '../../../data/models/checklist/workforce/save_reject_reasons.dart';
import 'checklist_events.dart';
import 'checklist_states.dart';

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
    on<PopulateQuestion>(_populateQuestions);
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
          } else if (getQuestionListModel.data!.questionlist![i].optionid !=
              null) {
            answerText =
                getQuestionListModel.data!.questionlist![i].optionid.toString();
          }
          answerList.add({
            "id": getQuestionListModel.data!.questionlist![i].id,
            "type": getQuestionListModel.data!.questionlist![i].type,
            "answer": answerText
          });
          log("bloc id==========>${answerList[i]["id"]}");
          log("bloc answer==========>${answerList[i]["answer"]}");
        }
        log("answer listt==========>$answerList");
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
      log("ye hai map jo post ho gaya=====>$saveRejectReasonMap");
      emit(RejectReasonsSaved(postRejectReasonsModel: postRejectReasonsModel));
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
      log("mapp save comment=====>$saveQuestionCommentMap");
    } catch (e) {
      emit(QuestionCommentsNotSaved(message: e.toString()));
    }
  }

  FutureOr<void> _submitQuestions(
      SubmitQuestions event, Emitter<WorkforceChecklistStates> emit) async {
    emit(SubmittingQuestion());
    try {
      log("event edit questions list=====>${event.editQuestionsList}");
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
        "isdraft": allDataForChecklistMap["isDraft"],
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

  _populateQuestions(
      PopulateQuestion event, Emitter<WorkforceChecklistStates> emit) async {
    List populateQuestions = List.from(answerList);
    List updateAnswer = List.from(answerList);
    log("populate questions========>$populateQuestions");
    for (int i = 0; i < answerList.length; i++) {
      if (answerList[i]["type"] == 3) {
        int match = questionList!
            .indexWhere((element) => element.id == answerList[i]["id"]);
        int optionIndex = questionList![match].queoptions!.indexWhere(
            (element) =>
                element["queoptionid"].toString() ==
                answerList[i]["answer"].toString());
        log("match============>$match");
        log("optionIndex============>$optionIndex");
        populateQuestions[i]["answer"] =
            questionList![match].queoptions![optionIndex]["queoptiontext"];
      }
    }
    emit(SavedQuestions(
      answerModelList: questionList!,
      populateAnswerList: populateQuestions,
      allChecklistDataMap: allDataForChecklistMap,
      updateAnswer: updateAnswer,
    ));
    add(EditQuestions(editQuestionsList: []));
  }

  _editQuestions(
      EditQuestions event, Emitter<WorkforceChecklistStates> emit) async {
    log("event edites question======>${event.editQuestionsList}");
    log("submit list======>$submitList");
    emit(QuestionsEdited(questionsEditedList: submitList));
  }
}
