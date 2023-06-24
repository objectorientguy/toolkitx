import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';
import 'incident_repository.dart';

class IncidentRepositoryImpl extends IncidentRepository {
  @override
  Future<IncidentFetchRolesModel> fetchIncidentRole(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getroles?hashcode=$hashCode&userid=$userId");
    return IncidentFetchRolesModel.fromJson(response);
  }
}
