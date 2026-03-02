import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget e() => Expanded(child: this);
  Widget f([int flex = 1]) => Flexible(flex: flex, child: this);
  Widget p(EdgeInsets edgeInset) => Padding(padding: edgeInset, child: this);
  Widget fillW({double? height}) => SizedBox(height: height, width: double.infinity, child: this);
}