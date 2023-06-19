import 'package:toolkit/repositories/workforce/workforce_repository.dart';

import '../../data/models/workforce/workforce_fetch_comment_model.dart';
import '../../data/models/workforce/workforce_list_model.dart';
import '../../data/models/workforce/workforce_questions_list_model.dart';
import '../../data/models/workforce/workforce_save_comment_model.dart';
import '../../data/models/workforce/workforce_submit_answer_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class WorkforceChecklistRepositoryImpl extends WorkForceRepository {
  @override
  Future<WorkforceGetCheckListModel> fetchWorkforceList(
      String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/get?userid=$userId&hashcode=$hashCode&filter=");
    return WorkforceGetCheckListModel.fromJson(response);
  }

  @override
  Future<GetQuestionListModel> fetchQuestionsList(
      String scheduleId, String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getquestions?scheduleid=$scheduleId&userid=$userId&hashcode=$hashCode");
    return GetQuestionListModel.fromJson(response);
  }

  @override
  Future<GetQuestionCommentsModel> fetchComment(
      String questionResponseId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getquestionresponsecomments?queresponseid=$questionResponseId&hashcode=$hashCode");
    return GetQuestionCommentsModel.fromJson(response);
  }

  @override
  Future<SaveQuestionCommentsModel> saveComment(
      Map saveQuestionsCommentMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/SaveQuestionResponseComments",
        saveQuestionsCommentMap);
    return SaveQuestionCommentsModel.fromJson(response);
  }

  @override
  Future<SubmitQuestionModel> submitAnswer(Map submitAnswerMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}checklist/save", submitAnswerMap);
    return SubmitQuestionModel.fromJson(response);
  }
}
