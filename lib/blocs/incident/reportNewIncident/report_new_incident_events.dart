import '../../../data/models/incident/fetch_incident_master_model.dart';

abstract class ReportNewIncidentEvent {}

class FetchIncidentCategory extends ReportNewIncidentEvent {
  final String role;

  FetchIncidentCategory({required this.role});
}

class SelectIncidentCategory extends ReportNewIncidentEvent {
  final int index;
  final int itemIndex;
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final bool isSelected;
  final List multiSelectList;

  SelectIncidentCategory(
      {required this.multiSelectList,
      required this.isSelected,
      required this.fetchIncidentMasterModel,
      required this.index,
      required this.itemIndex});
}
