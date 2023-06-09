import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';

abstract class ScheduleDatesStates extends Equatable {}

class ScheduleDatesInitial extends ScheduleDatesStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchingScheduleDates extends ScheduleDatesStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DatesScheduled extends ScheduleDatesStates {
  final ChecklistScheduledByDatesModel getChecklistDetailsModel;
  final Map allChecklistDataMap;

  DatesScheduled(
      {required this.allChecklistDataMap,
      required this.getChecklistDetailsModel});

  @override
  List<Object?> get props => [allChecklistDataMap, getChecklistDetailsModel];
}

class DatesNotScheduled extends ScheduleDatesStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}
