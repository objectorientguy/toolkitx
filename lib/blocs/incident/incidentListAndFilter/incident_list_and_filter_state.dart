import '../../../data/models/incident/fetch_incidents_list_model.dart';

abstract class IncidentListAndFilterStates {}

class FetchIncidentsInitial extends IncidentListAndFilterStates {}

class FetchingIncidents extends IncidentListAndFilterStates {}

class IncidentsFetched extends IncidentListAndFilterStates {
  final FetchIncidentsListModel fetchIncidentsListModel;
  final Map filterMap;

  IncidentsFetched(
      {required this.filterMap, required this.fetchIncidentsListModel});
}

class IncidentsNotFetched extends IncidentListAndFilterStates {
  final String noIncidentsMessage;

  IncidentsNotFetched({required this.noIncidentsMessage});
}
