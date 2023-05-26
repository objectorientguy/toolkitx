import 'package:equatable/equatable.dart';

abstract class QualityManagementSates extends Equatable {}

class QualityManagementInitial extends QualityManagementSates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangeReportDropDownLoaded extends QualityManagementSates {
  final String reportValue;
  final String contractorValue;

  ChangeReportDropDownLoaded(
      {required this.reportValue, required this.contractorValue});

  @override
  List<Object?> get props => [reportValue, contractorValue];
}

class ChangeReportingDropDownLoaded extends QualityManagementSates {
  final String siteValue;
  final String locationValue;
  final String severityValue;
  final String impactValue;

  ChangeReportingDropDownLoaded(
      {required this.siteValue,
      required this.locationValue,
      required this.severityValue,
      required this.impactValue});

  @override
  List<Object?> get props =>
      [siteValue, locationValue, severityValue, impactValue];
}

class FilterStatusDropDownLoaded extends QualityManagementSates {
  final List selectedStatus;
  final List filterStatus;
  final int? itemIndex;

  FilterStatusDropDownLoaded(
      {required this.selectedStatus,
      required this.filterStatus,
      this.itemIndex});

  @override
  List<Object?> get props => [selectedStatus, itemIndex];
}
