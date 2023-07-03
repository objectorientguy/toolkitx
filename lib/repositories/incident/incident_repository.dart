import '../../data/models/incident/fetch_incident_master_model.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';

abstract class IncidentRepository {
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode, String filter, String role);

  Future<IncidentFetchRolesModel> fetchIncidentRole(
      String hashCode, String userId);

  Future<FetchIncidentMasterModel> fetchIncidentMaster(
      String hashCode, String role);
}
