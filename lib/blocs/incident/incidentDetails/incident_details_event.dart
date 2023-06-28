class FetchIncidentDetailsEvent {
  final String incidentId;
  final String role;

  FetchIncidentDetailsEvent({required this.incidentId, required this.role});
}
