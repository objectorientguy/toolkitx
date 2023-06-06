import '../../../data/models/checklist/systemUser/system_user_approve_model.dart';
import '../../../data/models/checklist/systemUser/system_user_category_model.dart';
import '../../../data/models/checklist/systemUser/system_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/system_user_edit_header_details_model.dart';
import '../../../data/models/checklist/systemUser/system_user_list_model.dart';
import '../../../data/models/checklist/systemUser/system_user_pdf_model.dart';
import '../../../data/models/checklist/systemUser/system_user_reject_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_save_third_party_approval_model.dart';
import '../../../data/models/checklist/systemUser/system_user_workfoce_list_model.dart';
import '../../../data/models/checklist/systemUser/system_user_submit_header_model.dart';

abstract class ChecklistRepository {
  Future<ChecklistListModel> fetchChecklist(int pageNo);

  Future<ChecklistScheduledByDatesModel> fetchChecklistDetails(
      String checklistId);

  Future<ChecklistWorkforceListModel> fetchChecklistStatus(
      String scheduleId, String role);

  Future<GetPdfModel> fetchPdf(String responseId);

  Future<CheckListRolesModel> fetchRoles(String userId);

  Future<GetFilterCategoryModel> fetchCategory(String userId);

  Future<CheckListEditHeaderDetailsModel> fetchEditHeader(String scheduleId);

  Future<ChecklistApproveModel> checklistApprove(Map postApproveDataMap);

  Future<ChecklistRejectModel> checklistReject(Map postRejectDataMap);

  Future<ChecklistSubmitHeaderModel> submitHeader(Map postSubmitHeaderMap);

  Future<SaveThirdPartyApproval> saveThirdPartyApproval(
      Map postThirdPartyApproval);
}
