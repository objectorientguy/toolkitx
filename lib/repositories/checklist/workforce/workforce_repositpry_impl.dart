import 'dart:developer';
import 'package:toolkit/data/models/checklist/workforce/list_model.dart';
import 'package:toolkit/data/models/checklist/workforce/questions_comments_model.dart';
import 'package:toolkit/data/models/checklist/workforce/questions_list_model.dart';
import 'package:toolkit/data/models/checklist/workforce/reject_reasons_model.dart';
import 'package:toolkit/data/models/checklist/workforce/save_questions_comments.dart';
import 'package:toolkit/data/models/checklist/workforce/save_reject_reasons.dart';
import 'package:toolkit/data/models/checklist/workforce/submit_questions.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import 'workforce_repository.dart';

class WorkforceChecklistRepositoryImpl extends WorkforceChecklistRepository {
  @override
  Future<WorkforceGetCheckListModel> fetchChecklist(
      String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/get?userid=$userId&hashcode=$hashCode&filter=");
    return WorkforceGetCheckListModel.fromJson(response);
  }

  @override
  Future<GetCheckListRejectReasonsModel> fetchChecklistRejectReason(
      String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getrejectreasons?hashcode=$hashCode");
    return GetCheckListRejectReasonsModel.fromJson(response);
  }

  @override
  Future<GetQuestionListModel> fetchChecklistQuestions(
      String scheduleId, String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getquestions?scheduleid=$scheduleId&userid=$userId&hashcode=$hashCode");
    return GetQuestionListModel.fromJson(response);
  }

  @override
  Future<PostRejectReasonsModel> saveRejectReasons(
      Map saveRejectReasonsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/rejectbyworkforce",
        saveRejectReasonsMap);
    log("headerrr post reject========>$response");
    return PostRejectReasonsModel.fromJson(response);
  }

  @override
  Future<GetQuestionCommentsModel> fetchQuestionsComments(
      String questionResponseId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getquestionresponsecomments?queresponseid=$questionResponseId&hashcode=$hashCode");
    return GetQuestionCommentsModel.fromJson(response);
  }

  @override
  Future<SaveQuestionCommentsModel> saveQuestionsComments(
      Map saveQuestionsCommentMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/SaveQuestionResponseComments",
        saveQuestionsCommentMap);
    return SaveQuestionCommentsModel.fromJson(response);
  }

  @override
  Future<SubmitQuestionModel> submitQuestions(Map submitQuestionMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}checklist/save", submitQuestionMap);
    return SubmitQuestionModel.fromJson(response);
  }
}
