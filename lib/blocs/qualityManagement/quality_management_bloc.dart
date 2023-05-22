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
  }

  FutureOr<void> _reportDropDownValueChanged(
      ReportQADropDown event, Emitter<QualityManagementSates> emit) async {
    try {
      emit(ChangeReportDropDownData(
          reportValue: event.reportValue,
          contractorValue: event.contractorValue));
    } catch (e) {
      e.toString();
    }
  }

  FutureOr<void> _reportingDropDownValueChanged(
      ReportingQADropDown event, Emitter<QualityManagementSates> emit) async {
    try {
      emit(ChangeReportingDropDownData(
          siteValue: event.siteValue,
          locationValue: event.locationValue,
          severityValue: event.severityValue,
          impactValue: event.impactValue));
    } catch (e) {
      e.toString();
    }
  }
}
