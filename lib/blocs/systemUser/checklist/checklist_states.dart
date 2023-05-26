import 'package:toolkit/data/models/systemUser/checklist/status_model.dart';

import '../../../data/models/systemUser/checklist/details_model.dart';
import '../../../data/models/systemUser/checklist/list_model.dart';

abstract class ChecklistStates {}

class ChecklistInitial extends ChecklistStates {}

class ChecklistFetching extends ChecklistStates {}

class ChecklistFetched extends ChecklistStates {
  GetChecklistModel getChecklistModel;

  ChecklistFetched({required this.getChecklistModel});
}

class ChecklistError extends ChecklistStates {
  final String errorMessage;

  ChecklistError({required this.errorMessage});
}

class ChecklistDetailsFetching extends ChecklistStates {}

class ChecklistDetailsFetched extends ChecklistStates {
  final GetChecklistDetailsModel getChecklistDetailsModel;
  final bool? isResponded;

  ChecklistDetailsFetched(
      {required this.getChecklistDetailsModel, this.isResponded = false});
}

class ChecklistDetailsError extends ChecklistStates {
  final String checklistId;

  ChecklistDetailsError({required this.checklistId});
}

class NavigatedToStatusScreen extends ChecklistStates {
  final GetChecklistDetailsData getChecklistDetailsData;

  NavigatedToStatusScreen({required this.getChecklistDetailsData});
}

class ChecklistStatusFetching extends ChecklistStates {}

class ChecklistStatusFetched extends ChecklistStates {
  final GetChecklistStatusModel getChecklistStatusModel;

  ChecklistStatusFetched({required this.getChecklistStatusModel});
}

class ChecklistStatusError extends ChecklistStates {
  final String statusMessage;

  ChecklistStatusError({required this.statusMessage});
}
