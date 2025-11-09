import 'package:flutter/material.dart';

extension HexColor on Color {
  String toHex({bool leadingHashSign = true, bool includeAlpha = true}) {
    final hex =
        '${leadingHashSign ? '#' : ''}'
        '${(includeAlpha) ? a.toInt().toRadixString(16).padLeft(2, '0') : ''}'
        '${((r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}'
        '${((g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}'
        '${((b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}';
    return hex;
  }
}
