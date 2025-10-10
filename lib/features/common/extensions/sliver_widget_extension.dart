import 'package:flutter/cupertino.dart';

extension SliverWidgetExtension on Widget {
  SliverToBoxAdapter s() => SliverToBoxAdapter(child: this);
}