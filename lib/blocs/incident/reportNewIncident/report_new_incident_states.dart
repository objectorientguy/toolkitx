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

class ReportNewIncidentAnonymousSelected extends ReportNewIncidentStates {
  final Map reportAnonymousMap;
  final String reportAnonymousId;

  ReportNewIncidentAnonymousSelected(
      {required this.reportAnonymousId, required this.reportAnonymousMap});
}

class ReportNewIncidentContractorSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final int selectContractorId;
  final String selectContractorName;

  ReportNewIncidentContractorSelected(
      {required this.fetchIncidentMasterModel,
      required this.selectContractorId,
      required this.selectContractorName});
}

class ReportNewIncidentSiteSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectSiteName;

  ReportNewIncidentSiteSelected(
      {required this.fetchIncidentMasterModel, required this.selectSiteName});
}

class ReportNewIncidentLocationSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectLocationName;

  ReportNewIncidentLocationSelected(
      {required this.fetchIncidentMasterModel,
      required this.selectLocationName});
}

class ReportNewIncidentAuthoritySelected extends ReportNewIncidentStates {
  final Map reportIncidentAuthorityMap;
  final String reportIncidentAuthorityId;

  ReportNewIncidentAuthoritySelected(
      {required this.reportIncidentAuthorityId,
      required this.reportIncidentAuthorityMap});
}

class ReportNewIncidentDateTimeDescValidated extends ReportNewIncidentStates {
  final String dateTimeDescValidationMessage;

  ReportNewIncidentDateTimeDescValidated(
      {required this.dateTimeDescValidationMessage});
}

class ReportNewIncidentDateTimeDescValidationComplete
    extends ReportNewIncidentStates {
  ReportNewIncidentDateTimeDescValidationComplete();
}

class ReportNewIncidentSiteLocationValidated extends ReportNewIncidentStates {
  final String siteLocationValidationMessage;

  ReportNewIncidentSiteLocationValidated(
      {required this.siteLocationValidationMessage});
}

class ReportNewIncidentSiteLocationValidationComplete
    extends ReportNewIncidentStates {
  ReportNewIncidentSiteLocationValidationComplete();
}

class ReportNewIncidentCustomFieldFetched extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;

  ReportNewIncidentCustomFieldFetched({required this.fetchIncidentMasterModel});
}

class ReportNewIncidentCustomFieldSelected extends ReportNewIncidentStates {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String reportIncidentCustomInfoOptionId;

  ReportNewIncidentCustomFieldSelected(
      {required this.fetchIncidentMasterModel,
      required this.reportIncidentCustomInfoOptionId});
}
