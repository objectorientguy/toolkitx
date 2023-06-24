import '../../../data/models/incident/incident_fetch_roles_model.dart';

abstract class IncidentGetAndChangeRoleEvent {}

class IncidentFetchRoles extends IncidentGetAndChangeRoleEvent {
  final String roleId;
  bool isChanged;

  IncidentFetchRoles({required this.roleId, this.isChanged = false});
}

class IncidentChangeRole extends IncidentGetAndChangeRoleEvent {
  final IncidentFetchRolesModel incidentFetchRolesModel;
  final String roleId;
  final bool isRoleSelected;

  IncidentChangeRole(
      {this.isRoleSelected = false,
      required this.incidentFetchRolesModel,
      required this.roleId});
}
