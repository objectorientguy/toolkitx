abstract class ScheduleDates {}

class FetchScheduleDatesList extends ScheduleDates {
  final String checklistId;
  final Map allChecklistDataMap;

  FetchScheduleDatesList(
      {required this.allChecklistDataMap, required this.checklistId});
}
