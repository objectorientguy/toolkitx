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
