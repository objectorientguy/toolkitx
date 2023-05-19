enum ChecklistPopUpMenuItems {
  approve(popupItems: 'Approve'),
  reject(popupItems: 'Reject'),
  thirdPartyApprove(popupItems: 'Third Party Approve'),
  editHeader(popupItems: 'Edit Header'),
  cancel(popupItems: 'Cancel');

  const ChecklistPopUpMenuItems({
    required this.popupItems,
  });

  final String popupItems;
}
