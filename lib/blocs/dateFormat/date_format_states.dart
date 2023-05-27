abstract class DateFormatStates {}

class DateFormatSelected extends DateFormatStates {
  final String? dateFormatValue;
  final String? dateFormatString;

  DateFormatSelected({this.dateFormatValue, this.dateFormatString});
}
