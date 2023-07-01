class FetchIncidentDetailsEvent {
  final String incidentId;
  final String role;
  final int tabBarIndex;

  FetchIncidentDetailsEvent(
      {required this.tabBarIndex,
      required this.incidentId,
      required this.role});
}
