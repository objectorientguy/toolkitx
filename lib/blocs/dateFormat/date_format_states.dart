abstract class DateFormatStates {}

class DateFormatLoading extends DateFormatStates {}

class DateFormatSelected extends DateFormatStates {
  final String dateFormatValue;
  final String dateFormatString;

  DateFormatSelected(
      {required this.dateFormatValue, required this.dateFormatString});
}
