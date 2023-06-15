import 'package:toolkit/data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_workforce_list_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_approve_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_reject_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';

abstract class SysUserCheckListRepository {
  Future<ChecklistListModel> fetchChecklist(
      int pageNo, String hashCode, String filter);

  Future<ChecklistScheduledByDatesModel> fetchScheduleDates(
      String checklistId, String hashCode);

  Future<CheckListWorkforceListModel> fetchWorkforceList(
      String scheduleId, String hashCode, String role);

  Future<CheckListRolesModel> fetchRole(String hashCode, String userId);

  Future<GetFilterCategoryModel> fetchCategory(String hashCode, String userId);

  Future<ChecklistApproveModel> checklistApprove(Map postApproveDataMap);

  Future<ChecklistRejectModel> checklistReject(Map postRejectDataMap);

  Future<SaveThirdPartyApproval> checklistThirdPartyApproval(
      Map postThirdPartyApprovalMap);

  Future<CheckListEditHeaderDetailsModel> fetchEditHeader(
      String scheduleId, String hashCode);

  Future<ChecklistSubmitHeaderModel> submitHeader(Map postSubmitHeaderMap);

  Future<GetPdfModel> fetchPdf(String responseId, String hashCode);
}
