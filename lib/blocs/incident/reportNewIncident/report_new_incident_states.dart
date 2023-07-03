import '../../../data/models/incident/fetch_incident_master_model.dart';

abstract class ReportNewIncidentStates {}

class ReportNewIncidentInitial extends ReportNewIncidentStates {}

class FetchingIncidentMaster extends ReportNewIncidentStates {}

class IncidentMasterFetched extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final List categoryList;
  final List categorySelectedList;
  final Map addNewIncidentMap;

  IncidentMasterFetched(
      {required this.addNewIncidentMap,
      required this.categorySelectedList,
      required this.categoryList,
      required this.fetchIncidentMasterModel});
}

class IncidentMasterNotFetched extends ReportNewIncidentStates {}

class ReportNewIncidentFetched extends ReportNewIncidentStates {
  final Map addNewIncidentMap;
  final List reportAnonymousList;
  final String reportAnonymous;
  final int selectContractorId;
  final String selectContractorName;

  ReportNewIncidentFetched(
      {required this.selectContractorName,
      required this.selectContractorId,
      required this.addNewIncidentMap,
      required this.reportAnonymous,
      required this.reportAnonymousList});
}
