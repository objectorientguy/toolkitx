import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/incident/incident_fetch_roles_model.dart';

abstract class IncidentRolesStates extends Equatable {}

class IncidentRoleInitial extends IncidentRolesStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingIncidentRoles extends IncidentRolesStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class IncidentRolesFetched extends IncidentRolesStates {
  final IncidentFetchRolesModel incidentFetchRolesModel;
  final String roleId;
  final bool isRoleSelected;

  IncidentRolesFetched(
      {required this.isRoleSelected,
      required this.roleId,
      required this.incidentFetchRolesModel});

  @override
  List<Object?> get props => [incidentFetchRolesModel, roleId];
}

class IncidentRolesNotFetched extends IncidentRolesStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class IncidentRoleChanged extends IncidentRolesStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}
