import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_event.dart';
import 'package:toolkit/blocs/checklist/workforce/submitAnswer/workforce_checklist_submit_answer_states.dart';
import 'package:toolkit/repositories/checklist/workforce/workforce_repository.dart';

import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/workforce/workforce_checklist_submit_answer_model.dart';
import '../../../../di/app_module.dart';

class SubmitAnswerBloc extends Bloc<SubmitAnswers, SubmitAnswerStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map allDataForChecklistMap = {};
  String questionResponseId = '';

  SubmitAnswerBloc() : super(SubmitAnswerInitial()) {
    on<SubmitAnswers>(_submitAnswers);
  }

  FutureOr<void> _submitAnswers(
      SubmitAnswers event, Emitter<SubmitAnswerStates> emit) async {
    emit(SubmittingAnswer());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      log("event edit questions list=====>${event.allChecklistDataMap}");
      log("draftt=========>${event.isDraft}");
      List submitList = [];
      String id = '';
      String answer = '';
      // String isMandatory = '';
      for (int j = 0; j < event.editQuestionsList.length; j++) {
        id = event.editQuestionsList[j]["questionid"];
        answer = event.editQuestionsList[j]["answer"];
        // isMandatory = event.editQuestionsList[j]["ismandatory"].toString();
        log("id=====>$id");
        log("answer====>$answer");
        submitList.add({"questionid": id, "answer": answer});
      }
      log("submit list======>$submitList");
      // if (isMandatory == "1") {
      //   emit(QuestionNotSubmitted(message: 'Please enter data'));
      // }
      // else {
      Map submitQuestionMap = {
        "checklistid": event.allChecklistDataMap["checklistId"],
        "workforceid": userId,
        "isdraft": (event.isDraft == true) ? "1" : "0",
        "questions": submitList,
        "scheduleid": event.allChecklistDataMap["scheduleId"],
        "hashcode": hashCode
      };
      log("submitQuestionMap======>$submitQuestionMap");
      SubmitQuestionModel submitQuestionModel =
          await _workForceRepository.submitAnswer(submitQuestionMap);
      emit(AnswerSubmitted(submitQuestionModel: submitQuestionModel));
      // }
    } catch (e) {
      emit(AnswerNotSubmitted(message: e.toString()));
    }
  }
}
