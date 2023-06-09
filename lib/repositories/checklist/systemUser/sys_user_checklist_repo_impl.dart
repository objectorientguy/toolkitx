import 'dart:developer';

import 'package:toolkit/data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';

import '../../../data/models/checklist/systemUser/system_user_list_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import 'sys_user_checklist_repo.dart';

class CheckListRepositoryImpl extends CheckListRepository {
  @override
  Future<ChecklistListModel> fetchChecklist(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getallchecklists?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    log("response======>$response");
    return ChecklistListModel.fromJson(response);
  }

  @override
  Future<ChecklistScheduledByDatesModel> fetchScheduleDates(
      String checklistId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getscheduleddates?checklistid=$checklistId&hashcode=$hashCode");
    return ChecklistScheduledByDatesModel.fromJson(response);
  }
}
