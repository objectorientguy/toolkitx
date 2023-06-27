abstract class ReportIncidentEvents {}

class LocationScreenExpansionChange extends ReportIncidentEvents {
  final String otherSite;
  final String otherLocation;
  final String reportToAuthorities;

  LocationScreenExpansionChange(
      {required this.otherSite,
      required this.otherLocation,
      required this.reportToAuthorities});
}

class HealthData extends ReportIncidentEvents {
  final String healthData;

  HealthData({required this.healthData});
}

class SelectCategory extends ReportIncidentEvents {
  final List selectedCategory;
  final int? listIndex;
  final int? itemIndex;

  SelectCategory(
      {required this.selectedCategory, this.listIndex, this.itemIndex});
}

class ReportIncidentScreenExpansionChange extends ReportIncidentEvents {
  final String reportAnonymously;
  final String contractor;
  final List? categoryData;

  ReportIncidentScreenExpansionChange(
      {this.categoryData,
      required this.reportAnonymously,
      required this.contractor});
}

class SelectInjuryMultiSelect extends ReportIncidentEvents {
  final List selectedInjuryNature;
  final List selectedInjuredArea;
  final int? natureIndex;
  final int? areaIndex;

  SelectInjuryMultiSelect(
      {required this.selectedInjuryNature,
      this.natureIndex,
      required this.selectedInjuredArea,
      this.areaIndex});
}
