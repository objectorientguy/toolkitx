import 'package:toolkit/data/models/incident/fetch_incidents_list_model.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import 'incident_repository.dart';

class IncidentRepositoryImpl extends IncidentRepository {
  @override
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/get?pageno=1&userid=$userId&hashcode=$hashCode&filter=&role=");
    return FetchIncidentsListModel.fromJson(response);
  }
}
