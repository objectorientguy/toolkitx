import '../../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';

abstract class ScheduleDatesResponse {}

class CheckScheduleDatesResponse extends ScheduleDatesResponse {
  final GetChecklistDetailsData getChecklistDetailsData;
  final String scheduleId;
  final String role;

  CheckScheduleDatesResponse(
      {required this.role,
      required this.getChecklistDetailsData,
      required this.scheduleId});
}

class WorkForceListFetch extends ScheduleDatesResponse {
  final String scheduleId;
  final String role;
  final List responseIds;

  WorkForceListFetch(
      {required this.responseIds,
      required this.role,
      required this.scheduleId});
}

class CheckBoxCheck extends ScheduleDatesResponse {
  final String responseId;
  final CheckListWorkforceListModel checkListWorkforceListModel;
  final List responseIdList;
  bool popUpBuilder;

  CheckBoxCheck(
      {required this.responseId,
      required this.checkListWorkforceListModel,
      required this.responseIdList,
      this.popUpBuilder = false});
}

class FetchPopUpMenu extends ScheduleDatesResponse {
  final List popUpMenuItems;
  final bool popUpMenuBuilder;

  FetchPopUpMenu(
      {required this.popUpMenuBuilder, required this.popUpMenuItems});
}
