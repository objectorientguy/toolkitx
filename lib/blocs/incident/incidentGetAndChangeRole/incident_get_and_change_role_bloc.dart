import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_events.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_states.dart';
import 'package:toolkit/repositories/incident/incident_repository.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/incident/incident_fetch_roles_model.dart';

class IncidentsRoleBloc
    extends Bloc<IncidentGetAndChangeRoleEvent, IncidentRolesStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';

  IncidentRolesStates get initialState => IncidentRoleInitial();

  IncidentsRoleBloc() : super(IncidentRoleInitial()) {
    on<IncidentFetchRoles>(_incidentFetchRoles);
    on<IncidentChangeRole>(_incidentChangeRole);
  }

  FutureOr<void> _incidentFetchRoles(
      IncidentFetchRoles event, Emitter<IncidentRolesStates> emit) async {
    emit(FetchingIncidentRoles());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      IncidentFetchRolesModel incidentFetchRolesModel =
          await _incidentRepository.fetchIncidentRole(hashCode, userId);
      if (incidentFetchRolesModel.status == 200 &&
          incidentFetchRolesModel.data!.isNotEmpty) {
        add(IncidentChangeRole(
            roleId: roleId, incidentFetchRolesModel: incidentFetchRolesModel));
      } else {
        emit(IncidentRolesNotFetched());
      }
    } catch (e) {
      emit(IncidentRolesNotFetched());
    }
  }

  _incidentChangeRole(
      IncidentChangeRole event, Emitter<IncidentRolesStates> emit) {
    roleId = event.roleId;
    if (event.roleId == '') {
      roleId = event.incidentFetchRolesModel.data![0].groupId.toString();
      emit(IncidentRolesFetched(
          roleId: roleId,
          isRoleSelected: event.isRoleSelected,
          incidentFetchRolesModel: event.incidentFetchRolesModel));
    } else {
      emit(IncidentRolesFetched(
          roleId: roleId,
          isRoleSelected: event.isRoleSelected,
          incidentFetchRolesModel: event.incidentFetchRolesModel));
    }
  }
}
