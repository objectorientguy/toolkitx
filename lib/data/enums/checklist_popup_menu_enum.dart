enum ChecklistPopUpMenuItems {
  approve(popupItems: 'Approve'),
  reject(popupItems: 'Reject'),
  thirdPartyApprove(popupItems: 'Third Party Approve'),
  editHeader(popupItems: 'Edit Header');

  const ChecklistPopUpMenuItems({
    required this.popupItems,
  });

  final String popupItems;
}
