import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import 'sys_user_schedule_dates_event.dart';

class ScheduleDatesBloc
    extends Bloc<FetchScheduleDatesList, ScheduleDatesStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String checklistId = '';

  ScheduleDatesStates get initialState => ScheduleDatesInitial();

  ScheduleDatesBloc() : super(ScheduleDatesInitial()) {
    on<FetchScheduleDatesList>(_fetchScheduleDatesList);
  }

  FutureOr<void> _fetchScheduleDatesList(
      FetchScheduleDatesList event, Emitter<ScheduleDatesStates> emit) async {
    emit(FetchingScheduleDates());
    try {
      checklistId = event.checklistId;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ChecklistScheduledByDatesModel getChecklistDetailsModel =
          await _sysUserCheckListRepository.fetchScheduleDates(
              event.checklistId, hashCode);
      emit(DatesScheduled(
          checklistScheduledByDatesModel: getChecklistDetailsModel,
          allChecklistDataMap: const {}));
    } catch (e) {
      emit(DatesNotScheduled());
    }
  }
}
