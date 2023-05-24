import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'quality_management_events.dart';
import 'quality_management_states.dart';

class QualityManagementBloc
    extends Bloc<QualityManagementEvents, QualityManagementSates> {
  QualityManagementSates get initialState => QualityManagementInitial();

  QualityManagementBloc() : super(QualityManagementInitial()) {
    on<ReportQADropDown>(_reportDropDownValueChanged);
    on<ReportingQADropDown>(_reportingDropDownValueChanged);
    on<FilterStatusDropDown>(_filterStatusDropDownValueChanged);
  }

  FutureOr<void> _reportDropDownValueChanged(
      ReportQADropDown event, Emitter<QualityManagementSates> emit) async {
    emit(ChangeReportDropDownLoaded(
        reportValue: event.reportValue,
        contractorValue: event.contractorValue));
  }

  FutureOr<void> _reportingDropDownValueChanged(
      ReportingQADropDown event, Emitter<QualityManagementSates> emit) async {
    emit(ChangeReportingDropDownLoaded(
        siteValue: event.siteValue,
        locationValue: event.locationValue,
        severityValue: event.severityValue,
        impactValue: event.impactValue));
  }

  FutureOr<void> _filterStatusDropDownValueChanged(
      FilterStatusDropDown event, Emitter<QualityManagementSates> emit) async {
    List changeData = List.from(event.selectedStatus);
    final List filterStatus = [
      "Created",
      "Reported",
      "Acknowledged",
      "Mitigation Defined",
      "Mitigation Approved"
    ];
    if (event.itemIndex != null) {
      if (event.selectedStatus.contains(filterStatus[event.itemIndex!]) !=
          true) {
        changeData.add(filterStatus[event.itemIndex!]);
      } else {
        changeData.remove(filterStatus[event.itemIndex!]);
      }
    }
    emit(FilterStatusDropDownLoaded(
        selectedStatus: changeData,
        itemIndex: event.itemIndex,
        filterStatus: filterStatus));
  }
}
