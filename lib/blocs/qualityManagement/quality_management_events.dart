abstract class QualityManagementEvents {}

class ReportQADropDown extends QualityManagementEvents {
  final String reportValue;
  final String contractorValue;

  ReportQADropDown({required this.reportValue, required this.contractorValue});
}

class ReportingQADropDown extends QualityManagementEvents {
  final String siteValue;
  final String locationValue;
  final String severityValue;
  final String impactValue;

  ReportingQADropDown(
      {required this.siteValue,
      required this.locationValue,
      required this.severityValue,
      required this.impactValue});
}

class FilterStatusDropDown extends QualityManagementEvents {
  final List selectedStatus;
  final int? itemIndex;

  FilterStatusDropDown({required this.selectedStatus, this.itemIndex});
}
