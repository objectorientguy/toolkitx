import '../../../data/models/incident/incident_details_model.dart';

abstract class IncidentDetailsStates {}

class IncidentDetailsInitial extends IncidentDetailsStates {}

class FetchingIncidentDetails extends IncidentDetailsStates {}

class IncidentDetailsFetched extends IncidentDetailsStates {
  final IncidentDetailsModel incidentDetailsModel;
  final List files;
  final String randomValue;

  IncidentDetailsFetched(
      {required this.randomValue,
      required this.files,
      required this.incidentDetailsModel});
}

class IncidentDetailsNotFetched extends IncidentDetailsStates {}
