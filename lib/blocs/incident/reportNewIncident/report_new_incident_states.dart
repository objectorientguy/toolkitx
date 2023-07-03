import '../../../data/models/incident/fetch_incident_master_model.dart';

abstract class ReportNewIncidentStates {}

class ReportNewIncidentInitial extends ReportNewIncidentStates {}

class FetchingIncidentCategory extends ReportNewIncidentStates {}

class IncidentCategoryFetched extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;

  IncidentCategoryFetched({required this.fetchIncidentMasterModel});
}

class IncidentCategoryNotFetched extends ReportNewIncidentStates {}
