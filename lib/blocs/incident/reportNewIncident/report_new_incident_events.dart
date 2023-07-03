abstract class ReportNewIncidentEvent {}

class FetchIncidentCategory extends ReportNewIncidentEvent {
  final String role;

  FetchIncidentCategory({required this.role});
}
