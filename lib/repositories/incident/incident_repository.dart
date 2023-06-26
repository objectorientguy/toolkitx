import '../../data/models/incident/fetch_incidents_list_model.dart';

abstract class IncidentRepository {
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode);
}
