import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_events.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_states.dart';
import 'package:toolkit/repositories/incident/incident_repository.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/incident/incident_fetch_roles_model.dart';

class IncidentFetchAndChangeRoleBloc extends Bloc<
    IncidentFetchAndChangeRoleEvent, IncidentFetchAndChangeRoleStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';

  IncidentFetchAndChangeRoleStates get initialState => IncidentRoleInitial();

  IncidentFetchAndChangeRoleBloc() : super(IncidentRoleInitial()) {
    on<IncidentFetchRoles>(_incidentFetchRoles);
    on<IncidentChangeRole>(_incidentChangeRole);
  }

  FutureOr<void> _incidentFetchRoles(IncidentFetchRoles event,
      Emitter<IncidentFetchAndChangeRoleStates> emit) async {
    emit(FetchingIncidentRoles());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      IncidentFetchRolesModel incidentFetchRolesModel =
          await _incidentRepository.fetchIncidentRole(hashCode, userId);
      if (roleId.isEmpty) {
        roleId = incidentFetchRolesModel.data![0].groupId;
      }
      emit(IncidentRolesFetched(
          roleId: roleId, incidentFetchRolesModel: incidentFetchRolesModel));
    } catch (e) {
      emit(IncidentRolesNotFetched());
    }
  }

  _incidentChangeRole(IncidentChangeRole event,
      Emitter<IncidentFetchAndChangeRoleStates> emit) {
    roleId = event.roleId;
    emit(IncidentRoleChanged(roleId: roleId));
  }
}
