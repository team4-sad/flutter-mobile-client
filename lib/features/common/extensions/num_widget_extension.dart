import 'package:flutter/cupertino.dart';

extension NumWidgetExtension on num {
  SizedBox vs() => SizedBox(height: toDouble());
  SliverToBoxAdapter svs() =>
      SliverToBoxAdapter(child: SizedBox(height: toDouble()));

  SizedBox hs() => SizedBox(width: toDouble());
  SliverToBoxAdapter shs() =>
      SliverToBoxAdapter(child: SizedBox(width: toDouble()));
}