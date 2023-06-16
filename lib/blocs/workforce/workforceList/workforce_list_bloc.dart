import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workforce/workforceList/workforce_list_events.dart';
import 'package:toolkit/blocs/workforce/workforceList/workforce_list_states.dart';
import 'package:toolkit/repositories/workforce/workforce_repository.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/workforce/workforce_list_model.dart';
import '../../../di/app_module.dart';

class WorkForceListBloc extends Bloc<FetchWorkForceList, WorkForceListStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  WorkForceListBloc() : super(FetchListInitial()) {
    on<FetchWorkForceList>(_fetchList);
  }

  FutureOr<void> _fetchList(
      FetchWorkForceList event, Emitter<WorkForceListStates> emit) async {
    emit(FetchingList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      log("user id====>$userId");
      log("hash code id====>$hashCode");
      WorkforceGetCheckListModel workforceGetCheckListModel =
          await _workForceRepository.fetchWorkforceList(userId, hashCode);
      emit(ListFetched(workforceGetCheckListModel: workforceGetCheckListModel));
    } catch (e) {
      emit(ListNotFetched());
    }
  }
}
