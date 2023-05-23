import 'package:equatable/equatable.dart';

abstract class IncidentEvents extends Equatable {}

class FilterStatusChanged extends IncidentEvents {
  final List selectedStatus;
  final int? listIndex;

  FilterStatusChanged({required this.selectedStatus, required this.listIndex});

  @override
  List<Object?> get props => [selectedStatus, listIndex];
}
