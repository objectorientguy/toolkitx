import 'package:toolkit/data/models/systemUser/checklist/details_model.dart';
import 'package:toolkit/data/models/systemUser/checklist/status_model.dart';
import 'package:toolkit/utils/constants/api_constants.dart';

import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../../data/models/systemUser/checklist/pdf_model.dart';
import '../../../utils/dio_client.dart';
import 'repository.dart';

class ChecklistRepositoryImpl extends ChecklistRepository {
  @override
  Future<GetChecklistModel> fetchChecklist() async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getallchecklists?pageno=1&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3&filter={}");
    return GetChecklistModel.fromJson(response);
  }

  @override
  Future<GetChecklistDetailsModel> fetchChecklistDetails(
      String checklistId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getscheduleddates?checklistid=$checklistId&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3");
    return GetChecklistDetailsModel.fromJson(response);
  }

  @override
  Future<GetChecklistStatusModel> fetchChecklistStatus(
      String scheduleId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getallworkforce?scheduleid=$scheduleId&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3&role=");
    return GetChecklistStatusModel.fromJson(response);
  }

  @override
  Future<GetPdfModel> fetchPdf(String responseId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/checklist/getpdf?responseid=$responseId&hashcode=vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0|3|1|1|cet_3");
    return GetPdfModel.fromJson(response);
  }
}
