import 'package:flutter/material.dart';

extension HexColor on Color {
  String toHex({bool leadingHashSign = true, bool includeAlpha = true}) => '${leadingHashSign ? '#' : ''}'
      '${(includeAlpha) ? a.toInt().toRadixString(16).padLeft(2, '0') : ''}'
      '${r.toInt().toRadixString(16).padLeft(2, '0')}'
      '${g.toInt().toRadixString(16).padLeft(2, '0')}'
      '${b.toInt().toRadixString(16).padLeft(2, '0')}';
}