import 'package:toolkit/data/models/permit/permit_roles_model.dart';

import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/workforce/workforce_list_model.dart';
import '../../data/models/workforce/workforce_questions_list_model.dart';

abstract class WorkForceRepository {
  Future<WorkforceGetCheckListModel> fetchWorkforceList(
      String userId, String hashCode);

  Future<GetQuestionListModel> fetchQuestionsList(
      String scheduleId, String userId, String hashCode);
}
