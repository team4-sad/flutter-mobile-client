import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget e() => Expanded(child: this);
  Widget f([int flex = 1]) => Flexible(child: this, flex: flex);
  Widget p(EdgeInsets edgeInset) => Padding(padding: edgeInset, child: this);
}