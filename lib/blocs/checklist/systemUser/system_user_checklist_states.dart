import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_save_third_party_approval_model.dart';

import '../../../data/models/checklist/systemUser/system_user_approve_model.dart';
import '../../../data/models/checklist/systemUser/system_user_category_model.dart';
import '../../../data/models/checklist/systemUser/system_user_change_role_model.dart';
import '../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../data/models/checklist/systemUser/system_user_edit_header_details_model.dart';
import '../../../data/models/checklist/systemUser/system_user_list_model.dart';
import '../../../data/models/checklist/systemUser/system_user_pdf_model.dart';
import '../../../data/models/checklist/systemUser/system_user_reject_model.dart';
import '../../../data/models/checklist/systemUser/system_user_workfoce_list_model.dart';
import '../../../data/models/checklist/systemUser/system_user_submit_header_model.dart';

abstract class ChecklistStates extends Equatable {}

class ChecklistInitial extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistFetching extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistFetched extends ChecklistStates {
  final ChecklistListModel getChecklistModel;

  ChecklistFetched({required this.getChecklistModel});

  @override
  List<Object?> get props => [getChecklistModel];
}

class ChecklistError extends ChecklistStates {
  final String errorMessage;

  ChecklistError({required this.errorMessage});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingChecklistScheduleDates extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistDatesScheduled extends ChecklistStates {
  final ChecklistScheduledByDatesModel getChecklistDetailsModel;
  final Map allChecklistDataMap;

  ChecklistDatesScheduled(
      {required this.allChecklistDataMap,
      required this.getChecklistDetailsModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistScheduleDatesError extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ResponseChecked extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingChecklistWorkforceList extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistWorkforceListFetched extends ChecklistStates {
  final ChecklistWorkforceListModel getChecklistStatusModel;
  final List selectedIdsList;
  final bool popUpMenuBuilder;
  final Map allChecklistDataMap;

  ChecklistWorkforceListFetched(
      {required this.allChecklistDataMap,
      this.popUpMenuBuilder = false,
      required this.getChecklistStatusModel,
      required this.selectedIdsList});

  @override
  List<Object?> get props => [selectedIdsList];
}

class ChecklistWorkforceListError extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingPdf extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PdfFetched extends ChecklistStates {
  final GetPdfModel getPdfModel;

  PdfFetched({required this.getPdfModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchPdfError extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingRoles extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RolesFetched extends ChecklistStates {
  final CheckListRolesModel checkListRolesModel;
  final String roleId;
  final String roleName;
  final bool isChanged;

  RolesFetched(
      {this.isChanged = false,
      required this.roleId,
      required this.roleName,
      required this.checkListRolesModel});

  @override
  List<Object?> get props => [checkListRolesModel, roleId, roleName];
}

class RolesSelected extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchRolesError extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CategoryFetching extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CategoryFetched extends ChecklistStates {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;

  CategoryFetched(
      {required this.categoryName, required this.getFilterCategoryData});

  @override
  List<Object?> get props => [getFilterCategoryData, categoryName];
}

class CategoryError extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingEditHeader extends ChecklistStates {
  final String scheduleId;

  FetchingEditHeader({required this.scheduleId});

  @override
  List<Object?> get props => [scheduleId];
}

class EditHeaderFetched extends ChecklistStates {
  final CheckListEditHeaderDetailsModel getCheckListEditHeaderModel;
  final Map allChecklistDataMap;

  EditHeaderFetched(
      {required this.allChecklistDataMap,
      required this.getCheckListEditHeaderModel});

  @override
  List<Object?> get props => [getCheckListEditHeaderModel];
}

class EditHeaderError extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PopUpMenuItemsFetched extends ChecklistStates {
  final List popUpMenuItems;

  PopUpMenuItemsFetched({required this.popUpMenuItems});

  @override
  List<Object?> get props => [popUpMenuItems];
}

class ChecklistApprovingData extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistDataApproved extends ChecklistStates {
  final ChecklistApproveModel postChecklistApproveModel;

  ChecklistDataApproved({required this.postChecklistApproveModel});

  @override
  List<Object?> get props => [postChecklistApproveModel];
}

class ChecklistApproveError extends ChecklistStates {
  final String message;

  ChecklistApproveError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class RejectingChecklist extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistRejected extends ChecklistStates {
  final ChecklistRejectModel postChecklistRejectModel;

  ChecklistRejected({required this.postChecklistRejectModel});

  @override
  List<Object?> get props => [postChecklistRejectModel];
}

class ChecklistNotRejected extends ChecklistStates {
  final String message;

  ChecklistNotRejected({required this.message});

  @override
  List<Object?> get props => [message];
}

class SubmittingHeader extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HeaderSubmitted extends ChecklistStates {
  final ChecklistSubmitHeaderModel postChecklistSubmitHeaderModel;

  HeaderSubmitted({required this.postChecklistSubmitHeaderModel});

  @override
  List<Object?> get props => [postChecklistSubmitHeaderModel];
}

class SubmitHeaderError extends ChecklistStates {
  final String message;

  SubmitHeaderError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ApprovingThirdParty extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ThirdPartyApproved extends ChecklistStates {
  final SaveThirdPartyApproval saveThirdPartyApproval;
  final Map thirdPartyApproveMap;

  ThirdPartyApproved(
      {required this.thirdPartyApproveMap,
      required this.saveThirdPartyApproval});

  @override
  List<Object?> get props => [saveThirdPartyApproval];
}

class ThirdPartyDisapprove extends ChecklistStates {
  final String message;

  ThirdPartyDisapprove({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
