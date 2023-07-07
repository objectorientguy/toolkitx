import 'package:equatable/equatable.dart';

import '../../../data/models/incident/incident_details_model.dart';

abstract class IncidentDetailsStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncidentDetailsInitial extends IncidentDetailsStates {
  @override
  List<Object?> get props => [];
}

class FetchingIncidentDetails extends IncidentDetailsStates {
  @override
  List<Object?> get props => [];
}

class IncidentDetailsFetched extends IncidentDetailsStates {
  final IncidentDetailsModel incidentDetailsModel;
  final String clientId;
  final Map editIncidentDetailsMap;

  IncidentDetailsFetched(
      {required this.editIncidentDetailsMap,
      required this.clientId,
      required this.incidentDetailsModel});

  @override
  List<Object?> get props => [];
}

class IncidentDetailsNotFetched extends IncidentDetailsStates {
  @override
  List<Object?> get props => [];
}

class IncidentDetailsPopUpMenuItemsFetched extends IncidentDetailsStates {
  final List popUpMenuItems;

  IncidentDetailsPopUpMenuItemsFetched({required this.popUpMenuItems});

  @override
  List<Object?> get props => [popUpMenuItems];
}
