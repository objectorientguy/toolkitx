class FetchIncidentDetailsEvent {
  final String incidentId;
  final String role;
  final int incidentLinkIndex;

  FetchIncidentDetailsEvent(
      {required this.incidentLinkIndex,
      required this.incidentId,
      required this.role});
}
