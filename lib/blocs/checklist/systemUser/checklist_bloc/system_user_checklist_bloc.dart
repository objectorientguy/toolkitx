import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checklist_bloc/system_user_checklist_states.dart';

import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/system_user_list_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repo.dart';
import 'system_user_checklist_events.dart';

class CheckListBloc extends Bloc<FetchCheckList, CheckListStates> {
  final CheckListRepository _checkListRepository = getIt<CheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  int page = 0;
  bool isFetching = false;

  CheckListStates get initialState => CheckListInitial();

  CheckListBloc() : super(CheckListInitial()) {
    on<FetchList>(_fetchList);
  }

  FutureOr<void> _fetchList(
      FetchList event, Emitter<CheckListStates> emit) async {
    emit(FetchingCheckList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ChecklistListModel getChecklistModel =
          await _checkListRepository.fetchChecklist(page, hashCode, "{}");
      if (getChecklistModel.status == 200) {
        emit(CheckListFetched(getChecklistModel: getChecklistModel));
        page++;
        log("pageee=====>$page");
      } else {
        emit(CheckListError(errorMessage: ''));
      }
    } catch (e) {
      emit(CheckListError(errorMessage: ''));
    }
  }
}
