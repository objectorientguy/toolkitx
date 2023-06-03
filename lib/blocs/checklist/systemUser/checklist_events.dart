import '../../../data/models/checklist/systemUser/category_model.dart';
import '../../../data/models/checklist/systemUser/change_role_model.dart';
import '../../../data/models/checklist/systemUser/details_model.dart';
import '../../../data/models/checklist/systemUser/status_model.dart';

abstract class ChecklistEvents {}

class FetchChecklist extends ChecklistEvents {}

class FetchChecklistScheduleDates extends ChecklistEvents {
  final String checklistId;

  FetchChecklistScheduleDates({required this.checklistId});
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

  FetchChecklistWorkforceList({required this.role, required this.scheduleId});
}

class FetchPdf extends ChecklistEvents {
  final String responseId;

  FetchPdf({required this.responseId});
}

class FetchRoles extends ChecklistEvents {
  final String userId;

  FetchRoles({required this.userId});
}

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

class FetchCategory extends ChecklistEvents {
  final String userId;

  FetchCategory({required this.userId});
}

class ChangeCategory extends ChecklistEvents {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;

  ChangeCategory(
      {required this.getFilterCategoryData, required this.categoryName});
}

class FetchEditHeader extends ChecklistEvents {
  final String scheduleId;

  FetchEditHeader({required this.scheduleId});
}

class StatusCheckBoxCheck extends ChecklistEvents {
  final String statusId;
  final List selectedStatus;
  final GetChecklistStatusModel getChecklistStatusModel;
  bool popUpBuilder;

  StatusCheckBoxCheck(
      {this.popUpBuilder = false,
      required this.selectedStatus,
      required this.statusId,
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
