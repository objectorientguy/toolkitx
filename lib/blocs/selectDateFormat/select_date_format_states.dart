abstract class DateFormatStates {}

class DateFormatInitial extends DateFormatStates {}

class DateFormatLoading extends DateFormatStates {}

class DateFormatLoaded extends DateFormatStates {
  String dateFormat;

  DateFormatLoaded({required this.dateFormat});
}

class DateFormatError extends DateFormatStates {
  final String message;

  DateFormatError({required this.message});
}

class DateFormatValidation extends DateFormatStates {
  final String message;

  DateFormatValidation({required this.message});
}
