class FetchIncidentDetailsEvent {
  final String incidentId;
  final String role;
  final int initialIndex;

  FetchIncidentDetailsEvent(
      {required this.initialIndex,
      required this.incidentId,
      required this.role});
}
