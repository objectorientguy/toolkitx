abstract class ReportNewIncidentEvent {}

class FetchIncidentMaster extends ReportNewIncidentEvent {
  final String role;

  FetchIncidentMaster({required this.role});
}

class SelectIncidentCategory extends ReportNewIncidentEvent {
  final int index;
  final int itemIndex;
  final bool isSelected;
  final List multiSelectList;
  final Map addNewIncidentMap;

  SelectIncidentCategory(
      {required this.addNewIncidentMap,
      required this.multiSelectList,
      required this.isSelected,
      required this.index,
      required this.itemIndex});
}

class ReportNewIncidentPrimary extends ReportNewIncidentEvent {}

class ReportIncidentAnonymousExpansionChange extends ReportNewIncidentEvent {
  final String reportAnonymousId;

  ReportIncidentAnonymousExpansionChange({required this.reportAnonymousId});
}

class ReportIncidentContractorListChange extends ReportNewIncidentEvent {
  final int selectContractorId;
  final String selectContractorName;

  ReportIncidentContractorListChange(
      {required this.selectContractorName, required this.selectContractorId});
}

class ReportNewIncidentLocationListChange extends ReportNewIncidentEvent {}

class ReportIncidentSiteListChange extends ReportNewIncidentEvent {
  final String selectSiteName;

  ReportIncidentSiteListChange({required this.selectSiteName});
}

class ReportIncidentLocationChange extends ReportNewIncidentEvent {
  final String locationName;

  ReportIncidentLocationChange({required this.locationName});
}

class ReportIncidentAuthorityExpansionChange extends ReportNewIncidentEvent {
  final String reportAuthorityId;

  ReportIncidentAuthorityExpansionChange({required this.reportAuthorityId});
}
