import 'package:equatable/equatable.dart';

import '../../../data/models/incident/fetch_permit_to_link_model.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../data/models/incident/saved_linked_permit_model.dart';

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

  IncidentDetailsFetched(
      {required this.clientId, required this.incidentDetailsModel});

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

class FetchingPermitToLink extends IncidentDetailsStates {}

class FetchedPermitToLink extends IncidentDetailsStates {
  final FetchPermitToLinkModel fetchPermitToLinkModel;

  FetchedPermitToLink({required this.fetchPermitToLinkModel});
}

class FetchPermitToLinkError extends IncidentDetailsStates {}

class SavingLinkedPermits extends IncidentDetailsStates {}

class SavedLinkedPermits extends IncidentDetailsStates {
  final SaveLinkedPermitModel saveLinkedPermitModel;

  SavedLinkedPermits({required this.saveLinkedPermitModel});
}

class LinkedPermitsNotSaved extends IncidentDetailsStates {
  final String permitNotSavedMessage;

  LinkedPermitsNotSaved({required this.permitNotSavedMessage});
}
