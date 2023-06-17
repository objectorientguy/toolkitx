import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_event.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class CheckListRoleBloc extends Bloc<CheckListRole, CheckListRoleStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';
  String roleName = '';

  CheckListRoleStates get initialState => RoleInitial();

  CheckListRoleBloc() : super(RoleInitial()) {
    on<FetchRoles>(_checkListFetchRoles);
    on<ChangeRole>(_checkListChangeRole);
  }

  FutureOr<void> _checkListFetchRoles(
      FetchRoles event, Emitter<CheckListRoleStates> emit) async {
    emit(FetchingRoles());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      CheckListRolesModel checkListRolesModel =
          await _sysUserCheckListRepository.fetchRole(hashCode, userId);
      if (checkListRolesModel.status == 200 &&
          checkListRolesModel.data!.isNotEmpty) {
        add(ChangeRole(
            roleId: roleId,
            roleName: roleName,
            checkListRolesModel: checkListRolesModel));
      } else {
        emit(RolesNotFetched());
      }
    } catch (e) {
      emit(RolesNotFetched());
    }
  }

  _checkListChangeRole(ChangeRole event, Emitter<CheckListRoleStates> emit) {
    roleId = event.roleId;
    roleName = event.roleName;
    emit(RolesFetched(
        roleId: event.roleId,
        roleName: event.roleName,
        checkListRolesModel: event.checkListRolesModel));
  }
}
