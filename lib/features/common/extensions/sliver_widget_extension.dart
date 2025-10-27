import 'package:flutter/cupertino.dart';

extension SliverWidgetExtension on Widget {
  SliverToBoxAdapter s() => SliverToBoxAdapter(child: this);
  SliverPadding sp(EdgeInsets edgeInsets) => SliverPadding(
    padding: edgeInsets,
    sliver: this,
  );
}