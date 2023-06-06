import 'package:intl/intl.dart';

abstract class DateUtil {
  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd.MM.yy').format(dateTime);
  }

  static List<String> splitDate(String dateTime) {
    List<String> parts = dateTime.split(" - ");
    String startDate = parts[0];
    String endDate = parts[1];

    List<String> startDateParts = startDate.split(" ");
    String startDateString = startDateParts[0];
    String startTimeString = startDateParts[1];

    List<String> endDateParts = endDate.split(" ");
    String endDateString = endDateParts[0];
    String endTimeString = endDateParts[1];
    return [startDateString, endDateString, startTimeString, endTimeString];
  }
}
