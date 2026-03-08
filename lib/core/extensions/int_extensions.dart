import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

extension IntExtensions on int {
  String asWeekdayShortName(Locale locale) {
    final date = DateTime(2024, 1, this);
    final formatter = DateFormat.E(locale.countryCode);
    final shortName = formatter.format(date);
    return shortName.substring(0, 2).toLowerCase();
  }
}
