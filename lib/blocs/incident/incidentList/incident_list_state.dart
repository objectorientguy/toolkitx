import '../../../data/models/incident/fetch_incidents_list_model.dart';

abstract class IncidentListStates {}

class FetchIncidentInitial extends IncidentListStates {}

class FetchingIncidents extends IncidentListStates {}

class IncidentsFetched extends IncidentListStates {
  final FetchIncidentsListModel fetchIncidentsListModel;

  IncidentsFetched({required this.fetchIncidentsListModel});
}

class IncidentsNotFetched extends IncidentListStates {
  final String noIncidentsMessage;

  IncidentsNotFetched({required this.noIncidentsMessage});
}
