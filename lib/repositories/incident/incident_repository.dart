import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';

abstract class IncidentRepository {
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode);

  Future<IncidentFetchRolesModel> fetchIncidentRole(
      String hashCode, String userId);
}
