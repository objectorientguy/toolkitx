import 'package:toolkit/data/models/systemUser/checklist/status_model.dart';

import '../../../data/models/systemUser/checklist/change_role_model.dart';
import '../../../data/models/systemUser/checklist/details_model.dart';
import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../../data/models/systemUser/checklist/pdf_model.dart';

abstract class ChecklistStates {}

class ChecklistInitial extends ChecklistStates {}

class ChecklistFetching extends ChecklistStates {}

class ChecklistFetched extends ChecklistStates {
  GetChecklistModel getChecklistModel;

  ChecklistFetched({required this.getChecklistModel});
}

class ChecklistError extends ChecklistStates {}

class ChecklistDetailsFetching extends ChecklistStates {}

class ChecklistDetailsFetched extends ChecklistStates {
  final GetChecklistDetailsModel getChecklistDetailsModel;

  ChecklistDetailsFetched({required this.getChecklistDetailsModel});
}

class ChecklistDetailsError extends ChecklistStates {}

class ResponseChecked extends ChecklistStates {}

class ChecklistStatusFetching extends ChecklistStates {}

class ChecklistStatusFetched extends ChecklistStates {
  final GetChecklistStatusModel getChecklistStatusModel;

  ChecklistStatusFetched({required this.getChecklistStatusModel});
}

class ChecklistStatusError extends ChecklistStates {}

class FetchingPdf extends ChecklistStates {}

class PdfFetched extends ChecklistStates {
  final GetPdfModel getPdfModel;

  PdfFetched({required this.getPdfModel});
}

class FetchPdfError extends ChecklistStates {}

class FetchingRoles extends ChecklistStates {}

class RolesFetched extends ChecklistStates {
  final GetCheckListRolesModel getCheckListRolesModel;

  RolesFetched({required this.getCheckListRolesModel});
}

class FetchRolesError extends ChecklistStates {}

class RolesChanged extends ChecklistStates {
  final String rolesValue;
  final String rolesString;

  RolesChanged({required this.rolesValue, required this.rolesString});
}
