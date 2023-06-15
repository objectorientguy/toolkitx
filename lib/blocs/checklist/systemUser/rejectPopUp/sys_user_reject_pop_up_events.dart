abstract class RejectEvent {}

class RejectCheckList extends RejectEvent {
  final Map rejectMap;
  final List responseIdList;

  RejectCheckList({required this.responseIdList, required this.rejectMap});
}
