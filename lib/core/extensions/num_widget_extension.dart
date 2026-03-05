import 'package:flutter/material.dart';

extension NumWidgetExtension on num {
  SizedBox vs() => SizedBox(height: toDouble());
  SliverToBoxAdapter svs() =>
      SliverToBoxAdapter(child: SizedBox(height: toDouble()));

  SizedBox hs() => SizedBox(width: toDouble());
  SliverToBoxAdapter shs() =>
      SliverToBoxAdapter(child: SizedBox(width: toDouble()));

  EdgeInsets bottom() => EdgeInsets.only(bottom: toDouble());
  EdgeInsets top() => EdgeInsets.only(top: toDouble());
  EdgeInsets left() => EdgeInsets.only(left: toDouble());
  EdgeInsets right() => EdgeInsets.only(right: toDouble());
  EdgeInsets horizontal() => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets vertical() => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets all() => EdgeInsets.all(toDouble());
}