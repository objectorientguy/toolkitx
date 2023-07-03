import '../../../data/models/incident/fetch_incident_master_model.dart';

abstract class ReportNewIncidentEvent {}

class FetchIncidentMaster extends ReportNewIncidentEvent {
  final String role;

  FetchIncidentMaster({required this.role});
}

class SelectIncidentCategory extends ReportNewIncidentEvent {
  final int index;
  final int itemIndex;
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final bool isSelected;
  final List multiSelectList;
  final Map addNewIncidentMap;

  SelectIncidentCategory(
      {required this.addNewIncidentMap,
      required this.multiSelectList,
      required this.isSelected,
      required this.fetchIncidentMasterModel,
      required this.index,
      required this.itemIndex});
}

class ReportIncidentExpansionChange extends ReportNewIncidentEvent {
  final String reportAnonymously;
  final int selectContractorId;
  final String selectContractorName;

  ReportIncidentExpansionChange(
      {required this.selectContractorName,
      required this.selectContractorId,
      required this.reportAnonymously});
}
