import '../../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';

abstract class CheckListRole {}

class FetchRoles extends CheckListRole {
  final String roleName;
  bool isChanged;

  FetchRoles({required this.roleName, this.isChanged = false});
}

class ChangeRole extends CheckListRole {
  final CheckListRolesModel checkListRolesModel;
  final String roleId;
  final String roleName;

  ChangeRole(
      {required this.checkListRolesModel,
      required this.roleId,
      required this.roleName});
}
