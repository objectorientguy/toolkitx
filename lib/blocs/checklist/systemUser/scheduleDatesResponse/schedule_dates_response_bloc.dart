import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class ScheduleDatesResponseBloc
    extends Bloc<ScheduleDatesResponse, ScheduleDatesResponseStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List responsesIdsList = [];
  String responseId = '';
  String scheduleId = '';
  String responseCount = '';

  ScheduleDatesResponseStates get initialState =>
      ScheduleDatesResponseInitial();

  ScheduleDatesResponseBloc() : super(ScheduleDatesResponseInitial()) {
    on<CheckScheduleDatesResponse>(_checkResponse);
    on<WorkForceListFetch>(_workforceListFetch);
    on<CheckBoxCheck>(_checkBoxCheck);
    on<FetchPopUpMenu>(_fetchPopUpMenuItems);
  }

  _checkResponse(CheckScheduleDatesResponse event,
      Emitter<ScheduleDatesResponseStates> emit) {
    scheduleId = event.scheduleId;
    if (event.getChecklistDetailsData.responsecount != 0) {
      add(WorkForceListFetch(
          responseIds: const [],
          role: event.role,
          scheduleId: event.scheduleId));
    } else {
      emit(NoResponseFound(
          noResponseMessage: 'No response found!',
          scheduleId: event.scheduleId));
    }
  }

  FutureOr<void> _workforceListFetch(WorkForceListFetch event,
      Emitter<ScheduleDatesResponseStates> emit) async {
    emit(FetchingWorkforceList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      CheckListWorkforceListModel checkListWorkforceListModel =
          await _sysUserCheckListRepository.fetchWorkforceList(
              event.scheduleId, hashCode, event.role);
      add(CheckBoxCheck(
          responseId: '',
          checkListWorkforceListModel: checkListWorkforceListModel,
          responseIdList: const []));
    } catch (e) {
      emit(WorkforceListError());
    }
  }

  _checkBoxCheck(
      CheckBoxCheck event, Emitter<ScheduleDatesResponseStates> emit) {
    List responseIdsList = List.from(event.responseIdList);
    if (event.responseId != '') {
      if (event.responseIdList.contains(event.responseId) != true) {
        responseIdsList.add(event.responseId);
        event.popUpBuilder = true;
      } else {
        responseIdsList.remove(event.responseId);
        event.popUpBuilder = false;
      }
    }
    responsesIdsList = List.from(responseIdsList);
    emit(WorkforceListFetched(
        checkListWorkforceListModel: event.checkListWorkforceListModel,
        selectedIdsList: responsesIdsList,
        popUpMenuBuilder: event.popUpBuilder));
  }

  _fetchPopUpMenuItems(
      FetchPopUpMenu event, Emitter<ScheduleDatesResponseStates> emit) {
    List popUpMenuItems = [
      'Approve',
      'Reject',
      'Third Party Approve',
      'Edit Header'
    ];
    if (event.popUpMenuBuilder == false) {
      popUpMenuItems.removeAt(2);
      popUpMenuItems.removeAt(1);
      popUpMenuItems.removeAt(0);
    }
    emit(PopUpMenuItemsFetched(popUpMenuItems: popUpMenuItems));
  }
}
