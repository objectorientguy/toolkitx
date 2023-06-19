import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workforce/popUpMenu/workforce_pop_up_menu_events.dart';
import 'package:toolkit/blocs/workforce/popUpMenu/workforce_pop_up_menu_states.dart';

class PopUpMenuItemsBloc
    extends Bloc<FetchPopUpMenuItems, WfPopUpMenuItemsFetched> {
  Map allDataForChecklistMap = {};

  PopUpMenuItemsBloc()
      : super(const WfPopUpMenuItemsFetched(
            allChecklistDataMap: {}, popUpMenuItems: [])) {
    on<FetchPopUpMenuItems>(_fetchPopUpMenuItems);
  }

  _fetchPopUpMenuItems(
      FetchPopUpMenuItems event, Emitter<WfPopUpMenuItemsFetched> emit) {
    List popUpMenuItems = ['Edit', 'Reject'];
    emit(WfPopUpMenuItemsFetched(
        popUpMenuItems: popUpMenuItems,
        allChecklistDataMap: allDataForChecklistMap));
  }
}
