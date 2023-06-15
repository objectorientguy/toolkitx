import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_event.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_change_role_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class UserRoleBloc extends Bloc<UserRole, UserRoleStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';
  String roleName = '';

  UserRoleStates get initialState => UserRoleInitial();

  UserRoleBloc() : super(UserRoleInitial()) {
    on<FetchRoles>(_fetchRoles);
    on<ChangeRole>(_changeRole);
  }

  FutureOr<void> _fetchRoles(
      FetchRoles event, Emitter<UserRoleStates> emit) async {
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

  _changeRole(ChangeRole event, Emitter<UserRoleStates> emit) {
    roleId = event.roleId;
    roleName = event.roleName;
    emit(RolesFetched(
        roleId: event.roleId,
        roleName: event.roleName,
        checkListRolesModel: event.checkListRolesModel));
  }
}
