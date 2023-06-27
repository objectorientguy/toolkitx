import 'package:equatable/equatable.dart';

abstract class IncidentStates extends Equatable {}

class IncidentInitial extends IncidentStates {
  @override
  List<Object?> get props => [];
}

class FilterStatusChangeLoaded extends IncidentStates {
  final List selectedStatus;
  final List status;

  FilterStatusChangeLoaded(
      {required this.selectedStatus, required this.status});

  @override
  List<Object?> get props => [selectedStatus];
}
