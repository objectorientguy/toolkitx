import 'package:equatable/equatable.dart';

abstract class QualityManagementSates extends Equatable {}

class QualityManagementInitial extends QualityManagementSates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangeReportDropDownData extends QualityManagementSates {
  final String reportValue;
  final String contractorValue;

  ChangeReportDropDownData(
      {required this.reportValue, required this.contractorValue});

  @override
  List<Object?> get props => [reportValue, contractorValue];
}

class ChangeReportingDropDownData extends QualityManagementSates {
  final String siteValue;
  final String locationValue;
  final String severityValue;
  final String impactValue;

  ChangeReportingDropDownData(
      {required this.siteValue,
      required this.locationValue,
      required this.severityValue,
      required this.impactValue});

  @override
  List<Object?> get props =>
      [siteValue, locationValue, severityValue, impactValue];
}
