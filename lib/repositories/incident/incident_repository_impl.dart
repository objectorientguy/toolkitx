import '../../../utils/constants/api_constants.dart';
import '../../../utils/dio_client.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../data/models/incident/fetch_incident_master_model.dart';
import '../../data/models/incident/incident_fetch_roles_model.dart';
import '../../data/models/incident/incident_injury_master.dart';
import '../../data/models/incident/incident_unlink_permit_model.dart';
import '../../data/models/incident/save_report_new_incident_model.dart';
import '../../data/models/incident/save_report_new_incident_photos_model.dart';
import '../../data/models/incident/save_injured_person_model.dart';
import 'incident_repository.dart';

class IncidentRepositoryImpl extends IncidentRepository {
  @override
  Future<IncidentFetchRolesModel> fetchIncidentRole(
      String hashCode, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getroles?hashcode=$hashCode&userid=$userId");
    return IncidentFetchRolesModel.fromJson(response);
  }

  @override
  Future<FetchIncidentsListModel> fetchIncidents(
      String userId, String hashCode, String filter, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/get?pageno=1&userid=$userId&hashcode=$hashCode&filter=$filter&role=$role");
    return FetchIncidentsListModel.fromJson(response);
  }

  @override
  Future<IncidentInjuryMasterModel> fetchInjuryMaster(String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getinjuredpersonmaster?hashcode=$hashCode");
    return IncidentInjuryMasterModel.fromJson(response);
  }

  @override
  Future<IncidentDetailsModel> fetchIncidentDetails(
      String incidentId, String hashCode, String userId, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getincident1?incidentid=$incidentId&hashcode=$hashCode&userid=$userId&role=$role");
    return IncidentDetailsModel.fromJson(response);
  }

  @override
  Future<IncidentUnlinkPermitModel> removeLinkedPermit(
      Map removeLinkedPermitMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/unlinkpermit", removeLinkedPermitMap);
    return IncidentUnlinkPermitModel.fromJson(response);
  }

  @override
  Future<FetchIncidentMasterModel> fetchIncidentMaster(
      String hashCode, String role) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}incident/getmaster?hashcode=$hashCode&role=$role");
    return FetchIncidentMasterModel.fromJson(response);
  }

  @override
  Future<SaveReportNewIncidentModel> saveIncident(
      Map reportNewIncidentMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}incident/save", reportNewIncidentMap);
    return SaveReportNewIncidentModel.fromJson(response);
  }

  @override
  Future<SaveReportNewIncidentPhotosModel> saveIncidentPhotos(
      Map saveIncidentPhotosMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/savecommentsfiles",
        saveIncidentPhotosMap);
    return SaveReportNewIncidentPhotosModel.fromJson(response);
  }

  @override
  Future<SaveInjuredPersonModel> saveInjuredPerson(Map injuredPersonMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}incident/saveinjuredperson", injuredPersonMap);
    return SaveInjuredPersonModel.fromJson(response);
  }
}
