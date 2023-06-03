import 'package:equatable/equatable.dart';

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
  final GetChecklistModel getChecklistModel;

  ChecklistFetched({required this.getChecklistModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistError extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingChecklistScheduleDates extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistDatesScheduled extends ChecklistStates {
  final GetChecklistDetailsModel getChecklistDetailsModel;

  ChecklistDatesScheduled({required this.getChecklistDetailsModel});

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
  final GetChecklistStatusModel getChecklistStatusModel;
  final List selectedStatusList;
  final bool popUpMenuBuilder;

  ChecklistWorkforceListFetched(
      {this.popUpMenuBuilder = false,
      required this.getChecklistStatusModel,
      required this.selectedStatusList});

  @override
  List<Object?> get props => [selectedStatusList];
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
  List<Object?> get props => throw UnimplementedError();
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
  final GetCheckListEditHeaderModel getCheckListEditHeaderModel;

  EditHeaderFetched({required this.getCheckListEditHeaderModel});

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
  final PostChecklistApproveModel postChecklistApproveModel;

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

class ChecklistRejectingData extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChecklistRejected extends ChecklistStates {
  final PostChecklistRejectModel postChecklistRejectModel;

  ChecklistRejected({required this.postChecklistRejectModel});

  @override
  List<Object?> get props => [postChecklistRejectModel];
}

class ChecklistRejectError extends ChecklistStates {
  final String message;

  ChecklistRejectError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SubmittingHeader extends ChecklistStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HeaderSubmitted extends ChecklistStates {
  final PostChecklistSubmitHeaderModel postChecklistSubmitHeaderModel;

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
