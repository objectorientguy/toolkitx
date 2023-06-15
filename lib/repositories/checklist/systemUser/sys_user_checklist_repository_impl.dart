import 'package:toolkit/repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import '../../../data/models/checklist/systemUser/sys_user_approve_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_reject_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';

class SysUserCheckListRepositoryImpl extends SysUserCheckListRepository {
  @override
  Future<ChecklistListModel> fetchChecklist(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getallchecklists?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    return ChecklistListModel.fromJson(response);
  }

  @override
  Future<ChecklistScheduledByDatesModel> fetchScheduleDates(
      String checklistId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getscheduleddates?checklistid=$checklistId&hashcode=$hashCode");
    return ChecklistScheduledByDatesModel.fromJson(response);
  }

  @override
  Future<CheckListWorkforceListModel> fetchWorkforceList(
      String scheduleId, String hashCode, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getallworkforce?scheduleid=$scheduleId&hashcode=$hashCode&role=$role");
    return CheckListWorkforceListModel.fromJson(response);
  }

  @override
  Future<CheckListRolesModel> fetchRole(String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getroles?hashcode=$hashCode&userid=$userId");
    return CheckListRolesModel.fromJson(response);
  }

  @override
  Future<GetFilterCategoryModel> fetchCategory(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getmaster?hashcode=$hashCode&userid=$userId");
    return GetFilterCategoryModel.fromJson(response);
  }

  @override
  Future<ChecklistApproveModel> checklistApprove(Map postApproveDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/approvechecklist",
        postApproveDataMap);
    return ChecklistApproveModel.fromJson(response);
  }

  @override
  Future<ChecklistRejectModel> checklistReject(Map postRejectDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/rejectchecklist", postRejectDataMap);
    return ChecklistRejectModel.fromJson(response);
  }

  @override
  Future<SaveThirdPartyApproval> checklistThirdPartyApproval(
      Map postThirdPartyApprovalMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/savethirdpartysign",
        postThirdPartyApprovalMap);
    return SaveThirdPartyApproval.fromJson(response);
  }

  @override
  Future<CheckListEditHeaderDetailsModel> fetchEditHeader(
      String scheduleId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/gettemplatecustomfields?scheduleid=$scheduleId&hashcode=$hashCode");
    return CheckListEditHeaderDetailsModel.fromJson(response);
  }

  @override
  Future<ChecklistSubmitHeaderModel> submitHeader(
      Map postSubmitHeaderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/savetemplatecustomfields",
        postSubmitHeaderMap);
    return ChecklistSubmitHeaderModel.fromJson(response);
  }

  @override
  Future<GetPdfModel> fetchPdf(String responseId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getpdf?responseid=$responseId&hashcode=$hashCode");
    return GetPdfModel.fromJson(response);
  }
}
