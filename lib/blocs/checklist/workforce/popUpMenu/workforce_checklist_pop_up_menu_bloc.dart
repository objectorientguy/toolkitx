import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/popUpMenu/workforce_checklist_pop_up_menu_events.dart';
import 'package:toolkit/blocs/checklist/workforce/popUpMenu/workforce_checklist_pop_up_menu_states.dart';

class WorkForceCheckListPopUpMenuItemsBloc extends Bloc<
    WorkForceCheckListFetchPopUpMenuItems,
    CheckListWorkForcePopUpMenuItemsFetched> {
  Map allDataForChecklistMap = {};

  WorkForceCheckListPopUpMenuItemsBloc()
      : super(const CheckListWorkForcePopUpMenuItemsFetched(
            allChecklistDataMap: {}, popUpMenuItems: [])) {
    on<WorkForceCheckListFetchPopUpMenuItems>(_fetchPopUpMenuItems);
  }

  _fetchPopUpMenuItems(WorkForceCheckListFetchPopUpMenuItems event,
      Emitter<CheckListWorkForcePopUpMenuItemsFetched> emit) {
    List popUpMenuItems = ['Edit', 'Reject'];
    emit(CheckListWorkForcePopUpMenuItemsFetched(
        popUpMenuItems: popUpMenuItems,
        allChecklistDataMap: allDataForChecklistMap));
  }
}
