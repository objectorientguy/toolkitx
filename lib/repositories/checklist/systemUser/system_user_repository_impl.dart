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
  Future<ChecklistListModel> fetchChecklist(int pageNo) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getallchecklists?pageno=$pageNo&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&filter={}");
    log("response======>$response");
    return ChecklistListModel.fromJson(response);
  }

  @override
  Future<ChecklistScheduledByDatesModel> fetchChecklistDetails(
      String checklistId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getscheduleddates?checklistid=$checklistId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91");
    return ChecklistScheduledByDatesModel.fromJson(response);
  }

  @override
  Future<ChecklistWorkforceListModel> fetchChecklistStatus(
      String scheduleId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getallworkforce?scheduleid=$scheduleId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&role=$role");
    log("schedule idddd====>$scheduleId");
    log("schedule role====>$role");
    log("urlll========>${"${ApiConstants.baseUrl}/api/checklist/getallworkforce?scheduleid=$scheduleId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&role=$role"}");
    return ChecklistWorkforceListModel.fromJson(response);
  }

  @override
  Future<GetPdfModel> fetchPdf(String responseId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getpdf?responseid=$responseId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91");
    log("reponse id=======>$responseId");
    return GetPdfModel.fromJson(response);
  }

  @override
  Future<CheckListRolesModel> fetchRoles(String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getroles?hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&userid=MQFmIsmjOcA38gtYss+3Tw==");
    log("role response=====>$response");
    return CheckListRolesModel.fromJson(response);
  }

  @override
  Future<GetFilterCategoryModel> fetchCategory(String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getmaster?hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&userid=W2mt1FgZTZTQWTIvm4wU1w==");
    return GetFilterCategoryModel.fromJson(response);
  }

  @override
  Future<CheckListEditHeaderDetailsModel> fetchEditHeader(
      String scheduleId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/gettemplatecustomfields?scheduleid=$scheduleId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91");
    return CheckListEditHeaderDetailsModel.fromJson(response);
  }

  @override
  Future<ChecklistApproveModel> checklistApprove(Map postApproveDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/approvechecklist",
        postApproveDataMap);
    return ChecklistApproveModel.fromJson(response);
  }

  @override
  Future<ChecklistRejectModel> checklistReject(Map postRejectDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/rejectchecklist",
        postRejectDataMap);
    return ChecklistRejectModel.fromJson(response);
  }

  @override
  Future<ChecklistSubmitHeaderModel> submitHeader(
      Map postSubmitHeaderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/savetemplatecustomfields",
        postSubmitHeaderMap);
    log("headerrr========>$response");
    return ChecklistSubmitHeaderModel.fromJson(response);
  }

  @override
  Future<SaveThirdPartyApproval> saveThirdPartyApproval(
      Map postThirdPartyApproval) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/savethirdpartysign",
        postThirdPartyApproval);
    log("headerr third party========>$response");
    return SaveThirdPartyApproval.fromJson(response);
  }
}
