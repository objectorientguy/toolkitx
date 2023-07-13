enum TodoStatusEnum {
  none(status: 'None', value: '-1'),
  created(status: 'Created', value: '0'),
  openForInformation(status: 'OpenForInformation', value: '1'),
  openForReview(status: 'OpenForReview', value: '2'),
  approved(status: 'Approved', value: '3'),
  rejected(status: 'Rejected', value: '4'),
  closed(status: 'Closed', value: '5');

  const TodoStatusEnum({required this.status, required this.value});

  final String status;
  final String value;
}
