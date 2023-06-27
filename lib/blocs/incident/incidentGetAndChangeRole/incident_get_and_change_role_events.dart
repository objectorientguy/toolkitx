abstract class IncidentFetchAndChangeRoleEvent {}

class IncidentFetchRoles extends IncidentFetchAndChangeRoleEvent {
  IncidentFetchRoles();
}

class IncidentChangeRole extends IncidentFetchAndChangeRoleEvent {
  final String roleId;

  IncidentChangeRole({required this.roleId});
}
