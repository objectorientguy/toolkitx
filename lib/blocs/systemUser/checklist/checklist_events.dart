import '../../../data/models/systemUser/checklist/details_model.dart';

abstract class ChecklistEvents {}

class FetchChecklist extends ChecklistEvents {}

class FetchChecklistDetails extends ChecklistEvents {
  final String checklistId;

  FetchChecklistDetails({required this.checklistId});
}

class NavigateToStatusScreen extends ChecklistEvents {
  final GetChecklistDetailsData getChecklistDetailsData;
  final GetChecklistDetailsModel getChecklistDetailsModel;
  final String scheduleId;

  NavigateToStatusScreen(
      {required this.getChecklistDetailsData,
      required this.getChecklistDetailsModel,
      required this.scheduleId});
}

class FetchChecklistStatus extends ChecklistEvents {
  final String scheduleId;

  FetchChecklistStatus({required this.scheduleId});
}
