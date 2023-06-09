import 'dart:developer';

import 'package:toolkit/data/models/checklist/systemUser/system_user_approve_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/system_user_edit_header_details_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/system_user_reject_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_save_third_party_approval_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/system_user_submit_header_model.dart';

import '../../../data/models/checklist/systemUser/system_user_category_model.dart';
import '../../../data/models/checklist/systemUser/system_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/system_user_list_model.dart';
import '../../../data/models/checklist/systemUser/system_user_pdf_model.dart';
import '../../../data/models/checklist/systemUser/system_user_workfoce_list_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import 'system_user_repository.dart';

class ChecklistRepositoryImpl extends ChecklistRepository {
  @override
  Future<ChecklistListModel> fetchChecklist(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getallchecklists?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    log("response======>$response");
    return ChecklistListModel.fromJson(response);
  }

  @override
  Future<ChecklistScheduledByDatesModel> fetchChecklistDetails(
      String checklistId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getscheduleddates?checklistid=$checklistId&hashcode=$hashCode");
    return ChecklistScheduledByDatesModel.fromJson(response);
  }

  @override
  Future<ChecklistWorkforceListModel> fetchChecklistStatus(
      String scheduleId, String hashCode, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getallworkforce?scheduleid=$scheduleId&hashcode=$hashCode&role=$role");
    log("schedule idddd====>$scheduleId");
    log("schedule role====>$role");
    log("urlll========>${"${ApiConstants.baseUrl}/api/checklist/getallworkforce?scheduleid=$scheduleId&hashcode=$hashCode&role=$role"}");
    return ChecklistWorkforceListModel.fromJson(response);
  }

  @override
  Future<GetPdfModel> fetchPdf(String responseId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getpdf?responseid=$responseId&hashcode=$hashCode");
    log("reponse id=======>$responseId");
    return GetPdfModel.fromJson(response);
  }

  @override
  Future<CheckListRolesModel> fetchRoles(String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/getroles?hashcode=$hashCode&userid=$userId");
    log("role response=====>$response");
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
  Future<CheckListEditHeaderDetailsModel> fetchEditHeader(
      String scheduleId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}checklist/gettemplatecustomfields?scheduleid=$scheduleId&hashcode=$hashCode");
    return CheckListEditHeaderDetailsModel.fromJson(response);
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
  Future<ChecklistSubmitHeaderModel> submitHeader(
      Map postSubmitHeaderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/savetemplatecustomfields",
        postSubmitHeaderMap);
    log("headerrr========>$response");
    return ChecklistSubmitHeaderModel.fromJson(response);
  }

  @override
  Future<SaveThirdPartyApproval> saveThirdPartyApproval(
      Map postThirdPartyApproval) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}checklist/savethirdpartysign",
        postThirdPartyApproval);
    log("headerr third party========>$response");
    return SaveThirdPartyApproval.fromJson(response);
  }
}
