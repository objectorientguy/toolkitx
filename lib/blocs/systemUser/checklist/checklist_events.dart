import '../../../data/models/systemUser/checklist/details_model.dart';

abstract class ChecklistEvents {}

class FetchChecklist extends ChecklistEvents {}

class FetchChecklistDetails extends ChecklistEvents {
  final String checklistId;

  FetchChecklistDetails({required this.checklistId});
}

class CheckResponse extends ChecklistEvents {
  final GetChecklistDetailsData getChecklistDetailsData;

  final String scheduleId;

  CheckResponse(
      {required this.getChecklistDetailsData, required this.scheduleId});
}

class FetchChecklistStatus extends ChecklistEvents {
  final String scheduleId;

  FetchChecklistStatus({required this.scheduleId});
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
  final String rolesValue;
  final String rolesString;

  ChangeRoles({required this.rolesValue, required this.rolesString});
}
