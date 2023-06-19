import 'package:equatable/equatable.dart';

class WfPopUpMenuItemsFetched extends Equatable {
  final List popUpMenuItems;
  final Map allChecklistDataMap;

  const WfPopUpMenuItemsFetched(
      {required this.allChecklistDataMap, required this.popUpMenuItems});

  @override
  List<Object?> get props => [allChecklistDataMap, popUpMenuItems];
}
