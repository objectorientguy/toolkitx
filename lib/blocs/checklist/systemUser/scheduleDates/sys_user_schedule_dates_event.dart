abstract class ScheduleDates {}

class FetchScheduleDatesList extends ScheduleDates {
  final String checklistId;

  FetchScheduleDatesList({required this.checklistId});
}
