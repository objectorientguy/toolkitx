abstract class IncidentListAndFilterEvent {}

class FetchIncidentListEvent extends IncidentListAndFilterEvent {
  final bool isFromHome;
  final String roleId;

  FetchIncidentListEvent({required this.roleId, required this.isFromHome});
}

class ApplyIncidentFilter extends IncidentListAndFilterEvent {
  final Map incidentFilterMap;

  ApplyIncidentFilter({required this.incidentFilterMap});
}

class ClearIncidentFilters extends IncidentListAndFilterEvent {
  ClearIncidentFilters();
}
