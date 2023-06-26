abstract class IncidentListAndFilterEvent {}

class FetchIncidentListEvent extends IncidentListAndFilterEvent {
  final bool isFromHome;

  FetchIncidentListEvent({required this.isFromHome});
}

class ApplyIncidentFilter extends IncidentListAndFilterEvent {
  final Map incidentFilterMap;

  ApplyIncidentFilter({required this.incidentFilterMap});
}

class ClearIncidentFilters extends IncidentListAndFilterEvent {
  ClearIncidentFilters();
}
