import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget e() => Expanded(child: this);
  Widget p(EdgeInsets edgeInset) => Padding(padding: edgeInset, child: this);
}