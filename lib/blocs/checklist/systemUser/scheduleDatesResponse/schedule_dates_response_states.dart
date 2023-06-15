import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';

abstract class ScheduleDatesResponseStates extends Equatable {}

class ScheduleDatesResponseInitial extends ScheduleDatesResponseStates {
  @override
  List<Object?> get props => [];
}

class NoResponseFound extends ScheduleDatesResponseStates {
  final String noResponseMessage;
  final String scheduleId;

  NoResponseFound({required this.scheduleId, required this.noResponseMessage});

  @override
  List<Object?> get props => [noResponseMessage, scheduleId];
}

class FetchingWorkforceList extends ScheduleDatesResponseStates {
  @override
  List<Object?> get props => [];
}

class WorkforceListFetched extends ScheduleDatesResponseStates {
  final CheckListWorkforceListModel checkListWorkforceListModel;
  final List selectedIResponseIdList;
  final bool popUpMenuBuilder;

  WorkforceListFetched(
      {this.popUpMenuBuilder = false,
      required this.checkListWorkforceListModel,
      required this.selectedIResponseIdList});

  @override
  List<Object?> get props =>
      [checkListWorkforceListModel, selectedIResponseIdList, popUpMenuBuilder];
}

class WorkforceListError extends ScheduleDatesResponseStates {
  @override
  List<Object?> get props => [];
}

class PopUpMenuItemsFetched extends ScheduleDatesResponseStates {
  final List popUpMenuItems;

  PopUpMenuItemsFetched({required this.popUpMenuItems});

  @override
  List<Object?> get props => [popUpMenuItems];
}
