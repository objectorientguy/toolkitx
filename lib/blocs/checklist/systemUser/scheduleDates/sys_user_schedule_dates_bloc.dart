import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_states.dart';

import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repo.dart';

class ScheduleDatesBloc
    extends Bloc<FetchScheduleDatesList, ScheduleDatesStates> {
  final CheckListRepository _checkListRepository = getIt<CheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  ScheduleDatesStates get initialState => ScheduleDatesInitial();

  ScheduleDatesBloc() : super(ScheduleDatesInitial()) {
    on<FetchScheduleDatesList>(_fetchScheduleDatesList);
  }

  FutureOr<void> _fetchScheduleDatesList(
      FetchScheduleDatesList event, Emitter<ScheduleDatesStates> emit) async {
    emit(FetchingScheduleDates());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ChecklistScheduledByDatesModel getChecklistDetailsModel =
          await _checkListRepository.fetchScheduleDates(
              event.checklistId, hashCode);
      emit(DatesScheduled(
          getChecklistDetailsModel: getChecklistDetailsModel,
          allChecklistDataMap: const {}));
    } catch (e) {
      emit(DatesNotScheduled());
    }
  }
}
