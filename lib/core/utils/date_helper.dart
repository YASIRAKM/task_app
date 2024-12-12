import 'package:intl/intl.dart';

class DateHelper {
  /// Formats a DateTime to dd-MM-yyyy
  static String formatToDDMMYYYY(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  /// Formats a DateTime to yyyy-MM-dd
  static String formatToYYYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Parses a date string in yyyy-MM-dd format to a DateTime
  static DateTime parseFromYYYYMMDD(String dateString) {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  }

  /// Parses a date string in yyyy-MM-dd format to a DateTime
  static DateTime parseFromDDMMYYYY(String dateString) {
    return DateFormat('dd-MM-yyyy').parse(dateString);
  }
}
