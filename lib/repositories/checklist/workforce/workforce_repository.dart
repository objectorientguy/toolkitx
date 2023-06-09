import 'package:toolkit/data/models/checklist/workforce/list_model.dart';

import '../../../data/models/checklist/workforce/questions_comments_model.dart';
import '../../../data/models/checklist/workforce/questions_list_model.dart';
import '../../../data/models/checklist/workforce/reject_reasons_model.dart';
import '../../../data/models/checklist/workforce/save_questions_comments.dart';
import '../../../data/models/checklist/workforce/save_reject_reasons.dart';
import '../../../data/models/checklist/workforce/submit_questions.dart';

abstract class WorkforceChecklistRepository {
  Future<WorkforceGetCheckListModel> fetchChecklist(
      String userId, String hashCode);

  Future<GetCheckListRejectReasonsModel> fetchChecklistRejectReason(
      String hashCode);

  Future<GetQuestionListModel> fetchChecklistQuestions(
      String scheduleId, String userId, String hashCode);

  Future<PostRejectReasonsModel> saveRejectReasons(Map saveRejectReasonsMap);

  Future<GetQuestionCommentsModel> fetchQuestionsComments(
      String questionResponseId, String hashCode);

  Future<SaveQuestionCommentsModel> saveQuestionsComments(
      Map saveQuestionsCommentMap);

  Future<SubmitQuestionModel> submitQuestions(Map submitQuestionMap);
}
