import 'package:intl/intl.dart';

abstract class DateUtil {
  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String formatDate(DateTime dateTime, String dateFormat) {
    return DateFormat(dateFormat).format(dateTime);
  }

  static List<String> splitDate(String dateTime) {
    List<String> startDateParts = dateTime.split(" ");
    String dateString = startDateParts[0];
    String timeString = startDateParts[1];

    return [dateString, timeString];
  }
}
