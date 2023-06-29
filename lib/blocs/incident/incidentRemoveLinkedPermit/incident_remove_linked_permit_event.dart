import '../../../data/models/incident/incident_details_model.dart';

abstract class IncidentLinkedPermitEvent {}

class IncidentRemoveLinkedPermitEvent extends IncidentLinkedPermitEvent {
  final String permitId;
  final List permitLinkedList;
  final int index;

  IncidentRemoveLinkedPermitEvent(
      {required this.index,
      required this.permitLinkedList,
      required this.permitId});
}

class IncidentPermitListFetched extends IncidentLinkedPermitEvent {
  final IncidentDetailsModel incidentDetailsModel;

  IncidentPermitListFetched({required this.incidentDetailsModel});
}
