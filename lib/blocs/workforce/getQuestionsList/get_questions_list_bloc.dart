import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/repositories/workforce/workforce_repository.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/workforce/workforce_questions_list_model.dart';
import '../../../di/app_module.dart';
import 'get_questions_list_events.dart';
import 'get_questions_list_states.dart';

class WorkForceQuestionsListBloc
    extends Bloc<FetchQuestions, WorkForceQuestionsStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List answerList = [];
  List<Questionlist>? questionList;
  Map allDataForChecklistMap = {};

  WorkForceQuestionsListBloc() : super(FetchQuestionsListInitial()) {
    on<FetchQuestions>(_fetchQuestions);
  }

  FutureOr<void> _fetchQuestions(
      FetchQuestions event, Emitter<WorkForceQuestionsStates> emit) async {
    emit(FetchingQuestionsList());
    answerList.clear();
    try {
      allDataForChecklistMap = event.checklistData;
      log("schedule iddd=====>${event.checklistData["scheduleId"]}");
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String answerText = '';
      GetQuestionListModel getQuestionListModel =
          await _workForceRepository.fetchQuestionsList(
              event.checklistData["scheduleId"], userId, hashCode);
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
          } else if (getQuestionListModel.data!.questionlist![i].optiontext !=
              null) {
            answerText = getQuestionListModel.data!.questionlist![i].optiontext
                .toString();
          }
          answerList.add({
            "questionid": getQuestionListModel.data!.questionlist![i].id,
            "answer": answerText,
            "ismandatory":
                getQuestionListModel.data!.questionlist![i].ismandatory
          });
        }
        log("answer text 1=======>$answerText");
        log("answer text 2=======>$answerText");
        emit(QuestionsListFetched(
            getQuestionListModel: getQuestionListModel,
            answerList: answerList,
            allChecklistDataMap: allDataForChecklistMap));
      }
    } catch (e) {
      emit(
          QuestionsListNotFetched(allChecklistDataMap: allDataForChecklistMap));
    }
  }
}
