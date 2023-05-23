import 'package:equatable/equatable.dart';

abstract class ReportIncidentStates extends Equatable {}

class ReportIncidentInitial extends ReportIncidentStates {
  @override
  List<Object?> get props => [];
}

class ReportIncidentLocationScreenLoaded extends ReportIncidentStates {
  final String site;
  final String location;
  final String reportToAuthorities;

  ReportIncidentLocationScreenLoaded(
      {required this.site,
      required this.location,
      required this.reportToAuthorities});

  @override
  List<Object?> get props => [site, location, reportToAuthorities];
}

class ReportIncidentHealthScreenLoaded extends ReportIncidentStates {
  final String healthData;

  ReportIncidentHealthScreenLoaded({
    required this.healthData,
  });

  @override
  List<Object?> get props => [healthData];
}

class SelectCategoryLoaded extends ReportIncidentStates {
  final List selectedCategory;
  final List category;

  SelectCategoryLoaded(
      {required this.selectedCategory, required this.category});

  @override
  List<Object?> get props => [selectedCategory];
}

class ReportIncidentScreenLoaded extends ReportIncidentStates {
  final String reportAnonymously;
  final String contractor;
  final List? categoryData;

  ReportIncidentScreenLoaded(
      {this.categoryData,
      required this.reportAnonymously,
      required this.contractor});

  @override
  List<Object?> get props => [reportAnonymously, contractor];
}

class InjuriesScreenMultiselectLoaded extends ReportIncidentStates {
  final List selectedInjuryNature;
  final List selectedInjuredArea;
  final List injuryNature;
  final List injuredArea;

  InjuriesScreenMultiselectLoaded(
      {required this.injuryNature,
      required this.injuredArea,
      required this.selectedInjuryNature,
      required this.selectedInjuredArea});

  @override
  List<Object?> get props => [selectedInjuryNature, selectedInjuredArea];
}
