import 'package:flutter/cupertino.dart';

extension NumWidgetExtension on num {
  SizedBox vs() => SizedBox(height: toDouble());
  SizedBox hs() => SizedBox(width: toDouble());
}