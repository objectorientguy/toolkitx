import 'package:intl/intl.dart';

abstract class DateUtil {
  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd.MM.yy').format(dateTime);
  }
}
