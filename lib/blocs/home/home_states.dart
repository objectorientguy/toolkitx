abstract class HomeStates {
  const HomeStates();
}

class HomeInitial extends HomeStates {
  const HomeInitial();
}

class ModulesLoaded extends HomeStates {
  const ModulesLoaded();
}

class DateAndTimeLoaded extends HomeStates {
  final DateTime dateTime;
  final String timeZoneName;
  const DateAndTimeLoaded({required this.dateTime, required this.timeZoneName});
}
