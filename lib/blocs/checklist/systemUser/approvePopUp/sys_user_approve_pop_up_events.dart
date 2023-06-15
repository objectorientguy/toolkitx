abstract class ApproveEvent {}

class ApproveCheckList extends ApproveEvent {
  final Map approveMap;
  final List responseIdList;

  ApproveCheckList({required this.responseIdList, required this.approveMap});
}
