abstract class IncidentDetailsEvent {}

class FetchIncidentDetailsEvent extends IncidentDetailsEvent {
  final String incidentId;
  final String role;
  final int initialIndex;

  FetchIncidentDetailsEvent(
      {required this.initialIndex,
      required this.incidentId,
      required this.role});
}

class IncidentDetailsFetchPopUpMenuItems extends IncidentDetailsEvent {
  final List popUpMenuItems;

  IncidentDetailsFetchPopUpMenuItems({required this.popUpMenuItems});
}
