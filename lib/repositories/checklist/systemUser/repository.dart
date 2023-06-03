import '../../../data/models/checklist/systemUser/approve_model.dart';
import '../../../data/models/checklist/systemUser/category_model.dart';
import '../../../data/models/checklist/systemUser/change_role_model.dart';
import '../../../data/models/checklist/systemUser/details_model.dart';
import '../../../data/models/checklist/systemUser/get_edit_header_model.dart';
import '../../../data/models/checklist/systemUser/list_model.dart';
import '../../../data/models/checklist/systemUser/pdf_model.dart';
import '../../../data/models/checklist/systemUser/reject_model.dart';
import '../../../data/models/checklist/systemUser/status_model.dart';
import '../../../data/models/checklist/systemUser/submit_header_model.dart';

abstract class ChecklistRepository {
  Future<GetChecklistModel> fetchChecklist();

  Future<GetChecklistDetailsModel> fetchChecklistDetails(String checklistId);

  Future<GetChecklistStatusModel> fetchChecklistStatus(
      String scheduleId, String role);

  Future<GetPdfModel> fetchPdf(String responseId);

  Future<CheckListRolesModel> fetchRoles(String userId);

  Future<GetFilterCategoryModel> fetchCategory(String userId);

  Future<GetCheckListEditHeaderModel> fetchEditHeader(String scheduleId);

  Future<PostChecklistApproveModel> checklistApprove(Map postApproveDataMap);

  Future<PostChecklistRejectModel> checklistReject(Map postRejectDataMap);

  Future<PostChecklistSubmitHeaderModel> submitHeader(Map postSubmitHeaderMap);
}
