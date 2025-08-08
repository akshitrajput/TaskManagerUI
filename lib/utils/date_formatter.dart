import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  static String formatDateWithYear(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
