import 'package:flutter_bloc/flutter_bloc.dart';

import 'incident_events.dart';
import 'incident_state.dart';

class IncidentBloc extends Bloc<IncidentEvents, IncidentStates> {
  IncidentStates get initialState => IncidentInitial();

  IncidentBloc() : super(IncidentInitial()) {
    on<FilterStatusChanged>(_filterStatusChanged);
  }

  _filterStatusChanged(
      FilterStatusChanged event, Emitter<IncidentStates> emit) async {
    List changeData = List.from(event.selectedStatus);
    final List filterStatus = [
      "Created",
      "Reported",
      "Acknowledged",
      "Mitigation Defined",
      "Mitigation Approved"
    ];
    if (event.listIndex != null) {
      if (event.selectedStatus.contains(filterStatus[event.listIndex!]) !=
          true) {
        changeData.add(filterStatus[event.listIndex!]);
      } else {
        changeData.remove(filterStatus[event.listIndex!]);
      }
    }
    emit(FilterStatusChangeLoaded(
        selectedStatus: changeData, status: filterStatus));
  }
}
