import 'dart:developer';

import 'package:toolkit/data/models/checklist/systemUser/approve_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/get_edit_header_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/reject_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/submit_header_model.dart';

import '../../../data/models/checklist/systemUser/category_model.dart';
import '../../../data/models/checklist/systemUser/change_role_model.dart';
import '../../../data/models/checklist/systemUser/details_model.dart';
import '../../../data/models/checklist/systemUser/list_model.dart';
import '../../../data/models/checklist/systemUser/pdf_model.dart';
import '../../../data/models/checklist/systemUser/status_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import 'repository.dart';

class ChecklistRepositoryImpl extends ChecklistRepository {
  @override
  Future<GetChecklistModel> fetchChecklist() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getallchecklists?pageno=1&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&filter={}");
    log("response======>$response");
    return GetChecklistModel.fromJson(response);
  }

  @override
  Future<GetChecklistDetailsModel> fetchChecklistDetails(
      String checklistId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getscheduleddates?checklistid=$checklistId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91");
    return GetChecklistDetailsModel.fromJson(response);
  }

  @override
  Future<GetChecklistStatusModel> fetchChecklistStatus(
      String scheduleId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getallworkforce?scheduleid=$scheduleId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&role=$role");
    log("schedule idddd====>$scheduleId");
    log("schedule role====>$role");
    log("urlll========>${"${ApiConstants.baseUrl}/api/checklist/getallworkforce?scheduleid=$scheduleId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91&role=$role"}");
    return GetChecklistStatusModel.fromJson(response);
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
  Future<GetCheckListEditHeaderModel> fetchEditHeader(String scheduleId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/gettemplatecustomfields?scheduleid=$scheduleId&hashcode=SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B|3|1|1|azot_91");
    return GetCheckListEditHeaderModel.fromJson(response);
  }

  @override
  Future<PostChecklistApproveModel> checklistApprove(
      Map postApproveDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/approvechecklist",
        postApproveDataMap);
    return PostChecklistApproveModel.fromJson(response);
  }

  @override
  Future<PostChecklistRejectModel> checklistReject(
      Map postRejectDataMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/rejectchecklist",
        postRejectDataMap);
    return PostChecklistRejectModel.fromJson(response);
  }

  @override
  Future<PostChecklistSubmitHeaderModel> submitHeader(
      Map postSubmitHeaderMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/checklist/savetemplatecustomfields",
        postSubmitHeaderMap);
    log("headerrr========>$response");
    return PostChecklistSubmitHeaderModel.fromJson(response);
  }
}
