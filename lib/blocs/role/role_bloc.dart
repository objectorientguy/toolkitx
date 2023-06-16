// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:toolkit/blocs/role/role_events.dart';
// import 'package:toolkit/blocs/role/role_states.dart';
// import '../../../data/models/permit/permit_roles_model.dart';
// import '../../../di/app_module.dart';
// import '../../../repositories/permit/permit_repository.dart';
// import '../../data/cache/cache_keys.dart';
// import '../../data/cache/customer_cache.dart';
//
// class RoleBloc extends Bloc<RoleEvents, PermitRoleStates> {
//   final PermitRepository _permitRepository = getIt<PermitRepository>();
//   final CustomerCache _customerCache = getIt<CustomerCache>();
//   ValueNotifier<bool> checkboxValue = ValueNotifier<bool>(false);
//
//   RoleBloc() : super(const FetchingPermitRoles()) {
//     on<GetPermitRoles>(_fetchPermitRoles);
//     on<SelectCheckBoxEvent>(_selectCheckBoxEvent);
//   }
//
//   FutureOr<void> _selectCheckBoxEvent(
//       SelectCheckBoxEvent event, Emitter<PermitRoleStates> emit) async {
//     emit(CheckboxSelected(event.selectedDatum));
//   }
//
//   FutureOr<void> _fetchPermitRoles(
//       GetPermitRoles event, Emitter<PermitRoleStates> emit) async {
//     try {
//       emit(const FetchingPermitRoles());
//       String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
//       String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
//       PermitRolesModel permitRolesModel =
//           await _permitRepository.fetchPermitRoles(hashCode, userId);
//       emit(PermitRolesFetched(permitRolesModel: permitRolesModel));
//     } catch (e) {
//       emit(const CouldNotFetchPermitRoles());
//       rethrow;
//     }
//   }
// }
