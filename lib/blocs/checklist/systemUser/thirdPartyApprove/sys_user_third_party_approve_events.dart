abstract class ThirdPartyApproveEvent {}

class ThirdPartyApproveCheckList extends ThirdPartyApproveEvent {
  final Map thirdPartyApproveMap;
  final List responseIdList;

  ThirdPartyApproveCheckList(
      {required this.responseIdList, required this.thirdPartyApproveMap});
}
