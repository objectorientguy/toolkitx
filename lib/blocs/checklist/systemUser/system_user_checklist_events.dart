import '../../../data/models/checklist/systemUser/system_user_category_model.dart';
import '../../../data/models/checklist/systemUser/system_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/system_user_workfoce_list_model.dart';

abstract class ChecklistEvents {}

class FetchChecklist extends ChecklistEvents {}

class FetchChecklistScheduleDates extends ChecklistEvents {
  final String checklistId;
  final Map allChecklistDataMap;

  FetchChecklistScheduleDates(
      {required this.allChecklistDataMap, required this.checklistId});
}

class CheckResponse extends ChecklistEvents {
  final GetChecklistDetailsData getChecklistDetailsData;
  final String scheduleId;

  CheckResponse(
      {required this.getChecklistDetailsData, required this.scheduleId});
}

class FetchChecklistWorkforceList extends ChecklistEvents {
  final String scheduleId;
  final String role;
  final List responseIds;

  FetchChecklistWorkforceList(
      {required this.responseIds,
      required this.role,
      required this.scheduleId});
}

class FetchPdf extends ChecklistEvents {
  final String responseId;

  FetchPdf({required this.responseId});
}

class FetchRoles extends ChecklistEvents {}

class ChangeRoles extends ChecklistEvents {
  final CheckListRolesModel checkListRolesModel;
  final String roleId;
  final String roleName;
  final bool isChanged;

  ChangeRoles(
      {this.isChanged = false,
      required this.checkListRolesModel,
      required this.roleId,
      required this.roleName});
}

class FetchCategory extends ChecklistEvents {}

class ChangeCategory extends ChecklistEvents {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;
  final String categoryId;

  ChangeCategory(
      {required this.categoryId,
      required this.getFilterCategoryData,
      required this.categoryName});
}

class FetchEditHeader extends ChecklistEvents {
  final String scheduleId;

  FetchEditHeader({required this.scheduleId});
}

class StatusCheckBoxCheck extends ChecklistEvents {
  final String responseId;
  final List selectedResponseIds;
  final ChecklistWorkforceListModel getChecklistStatusModel;
  bool popUpBuilder;

  StatusCheckBoxCheck(
      {this.popUpBuilder = false,
      required this.selectedResponseIds,
      required this.responseId,
      required this.getChecklistStatusModel});
}

class FetchPopUpMenu extends ChecklistEvents {
  final List popUpMenuItems;
  final bool popUpMenuBuilder;

  FetchPopUpMenu(
      {required this.popUpMenuBuilder, required this.popUpMenuItems});
}

class ChecklistApprove extends ChecklistEvents {
  final Map approveMap;

  ChecklistApprove({required this.approveMap});
}

class ChecklistReject extends ChecklistEvents {
  final Map rejectMap;

  ChecklistReject({required this.rejectMap});
}

class SubmitHeader extends ChecklistEvents {
  final Map submitHeaderMap;
  final List submitHeaderList;

  SubmitHeader({required this.submitHeaderList, required this.submitHeaderMap});
}

class ThirdPartyApprove extends ChecklistEvents {
  final Map thirdPartyApprove;

  ThirdPartyApprove({required this.thirdPartyApprove});
}

class FilterChecklist extends ChecklistEvents {
  final Map filterChecklistMap;

  FilterChecklist({required this.filterChecklistMap});
}
