import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';

abstract class ScheduleDatesStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ScheduleDatesInitial extends ScheduleDatesStates {}

class FetchingScheduleDates extends ScheduleDatesStates {}

class DatesScheduled extends ScheduleDatesStates {
  final ChecklistScheduledByDatesModel checklistScheduledByDatesModel;
  final Map allChecklistDataMap;

  DatesScheduled(
      {required this.allChecklistDataMap,
      required this.checklistScheduledByDatesModel});

  @override
  List<Object?> get props =>
      [allChecklistDataMap, checklistScheduledByDatesModel];
}

class DatesNotScheduled extends ScheduleDatesStates {}
