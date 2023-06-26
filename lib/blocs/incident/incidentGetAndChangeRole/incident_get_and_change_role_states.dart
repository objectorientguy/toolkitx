import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/incident/incident_fetch_roles_model.dart';

abstract class IncidentFetchAndChangeRoleStates extends Equatable {}

class IncidentRoleInitial extends IncidentFetchAndChangeRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingIncidentRoles extends IncidentFetchAndChangeRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class IncidentRolesFetched extends IncidentFetchAndChangeRoleStates {
  final IncidentFetchRolesModel incidentFetchRolesModel;
  final String roleId;

  IncidentRolesFetched(
      {required this.roleId, required this.incidentFetchRolesModel});

  @override
  List<Object?> get props => [incidentFetchRolesModel, roleId];
}

class IncidentRolesNotFetched extends IncidentFetchAndChangeRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class IncidentRoleChanged extends IncidentFetchAndChangeRoleStates {
  final String roleId;

  IncidentRoleChanged({required this.roleId});

  @override
  List<Object?> get props => throw UnimplementedError();
}
