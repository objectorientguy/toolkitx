import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';

abstract class CheckListRoleStates extends Equatable {}

class RoleInitial extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingRoles extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RolesFetched extends CheckListRoleStates {
  final CheckListRolesModel checkListRolesModel;
  final String roleId;
  final String roleName;

  RolesFetched(
      {required this.roleId,
      required this.roleName,
      required this.checkListRolesModel});

  @override
  List<Object?> get props => [checkListRolesModel, roleId, roleName];
}

class RolesNotFetched extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RoleChanged extends CheckListRoleStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}
