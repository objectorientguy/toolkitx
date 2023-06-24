import '../../data/models/incident/incident_fetch_roles_model.dart';

abstract class IncidentRepository {
  Future<IncidentFetchRolesModel> fetchIncidentRole(
      String hashCode, String userId);
}
