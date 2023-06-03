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
import 'repository.dart';

class WorkforceChecklistRepositoryImpl extends WorkforceChecklistRepository {
  @override
  Future<WorkforceGetCheckListModel> fetchChecklist() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}api/checklist/get?userid=W2mt1FgZTZTQWTIvm4wU1w==&hashcode=9i2CF+lFcvH59NOsOTI9b2POWg0nKle29CpuaapAGRJGICrBkG7OH4mA2ip4z1yY|3|2|1|ist_42&filter=");
    log("response======>$response");
    return WorkforceGetCheckListModel.fromJson(response);
  }

  @override
  Future<GetCheckListRejectReasonsModel> fetchChecklistRejectReason() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}api/checklist/getrejectreasons?hashcode=9i2CF+lFcvH59NOsOTI9b2POWg0nKle29CpuaapAGRJGICrBkG7OH4mA2ip4z1yY|3|2|1|ist_42");
    return GetCheckListRejectReasonsModel.fromJson(response);
  }

  @override
  Future<GetQuestionListModel> fetchChecklistQuestions(
      String scheduleId, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getquestions?scheduleid=$scheduleId&userid=W2mt1FgZTZTQWTIvm4wU1w==&hashcode=9i2CF+lFcvH59NOsOTI9b2POWg0nKle29CpuaapAGRJGICrBkG7OH4mA2ip4z1yY|3|2|1|ist_42");
    return GetQuestionListModel.fromJson(response);
  }

  @override
  Future<PostRejectReasonsModel> saveRejectReasons(
      Map saveRejectReasonsMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/rejectbyworkforce",
        saveRejectReasonsMap);
    log("headerrr post reject========>$response");
    return PostRejectReasonsModel.fromJson(response);
  }

  @override
  Future<GetQuestionCommentsModel> fetchQuestionsComments(
      String questionResponseId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getquestionresponsecomments?queresponseid=$questionResponseId&hashcode=9i2CF+lFcvH59NOsOTI9b2POWg0nKle29CpuaapAGRJGICrBkG7OH4mA2ip4z1yY|3|2|1|ist_42");
    return GetQuestionCommentsModel.fromJson(response);
  }

  @override
  Future<SaveQuestionCommentsModel> saveQuestionsComments(
      Map saveQuestionsCommentMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/SaveQuestionResponseComments",
        saveQuestionsCommentMap);
    return SaveQuestionCommentsModel.fromJson(response);
  }

  @override
  Future<SubmitQuestionModel> submitQuestions(Map submitQuestionMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}/api/checklist/save", submitQuestionMap);
    log("saveee responsee======>$response");
    log("saveee mappp======>$submitQuestionMap");
    return SubmitQuestionModel.fromJson(response);
  }
}
