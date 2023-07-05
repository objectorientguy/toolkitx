abstract class ReportNewIncidentEvent {}

class FetchIncidentMaster extends ReportNewIncidentEvent {
  final String role;

  FetchIncidentMaster({required this.role});
}

class SelectIncidentCategory extends ReportNewIncidentEvent {
  final int? selectedCategory;
  final List multiSelectList;

  SelectIncidentCategory(
      {required this.selectedCategory, required this.multiSelectList});
}

class ReportNewIncidentAnonymousExpansionChange extends ReportNewIncidentEvent {
  final String reportIncidentAnonymousId;

  ReportNewIncidentAnonymousExpansionChange(
      {required this.reportIncidentAnonymousId});
}

class ReportNewIncidentContractorListChange extends ReportNewIncidentEvent {
  final int selectContractorId;
  final String selectContractorName;

  ReportNewIncidentContractorListChange(
      {required this.selectContractorName, required this.selectContractorId});
}

class ReportNewIncidentLocationListChange extends ReportNewIncidentEvent {}

class ReportIncidentSiteListChange extends ReportNewIncidentEvent {
  final String selectSiteName;

  ReportIncidentSiteListChange({required this.selectSiteName});
}

class ReportNewIncidentLocationChange extends ReportNewIncidentEvent {
  final String selectLocationName;

  ReportNewIncidentLocationChange({required this.selectLocationName});
}

class ReportNewIncidentAuthorityExpansionChange extends ReportNewIncidentEvent {
  final String reportIncidentAuthorityId;

  ReportNewIncidentAuthorityExpansionChange(
      {required this.reportIncidentAuthorityId});
}

class ReportNewIncidentDateTimeDescriptionValidation
    extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;

  ReportNewIncidentDateTimeDescriptionValidation(
      {required this.reportNewIncidentMap});
}

class ReportNewIncidentSiteLocationValidation extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;

  ReportNewIncidentSiteLocationValidation({required this.reportNewIncidentMap});
}

class ReportNewIncidentCustomInfoFieldFetch extends ReportNewIncidentEvent {
  ReportNewIncidentCustomInfoFieldFetch();
}

class ReportNewIncidentCustomInfoFiledExpansionChange
    extends ReportNewIncidentEvent {
  final String reportIncidentCustomInfoOptionId;

  ReportNewIncidentCustomInfoFiledExpansionChange(
      {required this.reportIncidentCustomInfoOptionId});
}

class SaveReportNewIncident extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;
  final String role;

  SaveReportNewIncident(
      {required this.role, required this.reportNewIncidentMap});
}

class SaveReportNewIncidentPhotos extends ReportNewIncidentEvent {
  final Map reportNewIncidentMap;

  SaveReportNewIncidentPhotos({required this.reportNewIncidentMap});
}
