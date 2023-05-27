enum UserType {
  systemUser(type: 'System User', value: '1'),
  workForce(type: 'Workforce', value: '2');

  const UserType({required this.type, required this.value});

  final String type;
  final String value;
}
