import 'dart:ui';
import 'package:miigaik/features/common/extensions/int_extensions.dart';

extension DateTimeExtensions on DateTime {
  DateTime startOfWeek({int startWeekday = DateTime.monday}) {
    int diff = weekday - startWeekday;
    if (diff < 0) diff += 7;
    return DateTime(year, month, day).subtract(Duration(days: diff));
  }

  DateTime startOfMonth() {
    return DateTime(year, month, 1);
  }

  int calcCountDaysInMonth() {
    // Особенность Dart, где день 0 означает последний день предыдущего месяца
    return DateTime(year, month + 1, 0).day;
  }

  String getWeekdayShortName(Locale locale) {
    return weekday.asWeekdayShortName(locale);
  }

  DateTime onlyDate() => DateTime(year, month, day);

  bool isBetween(DateTime start, DateTime end) {
    return start.isBefore(this) && end.isAfter(this);
  }

  DateTime setDate(DateTime onlyDate) {
    return DateTime(
      onlyDate.year,
      onlyDate.month,
      onlyDate.day,
      hour,
      minute,
      second,
    );
  }
}
