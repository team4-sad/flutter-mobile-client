import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/iterable_extensions.dart';
import 'package:miigaik/core/extensions/widget_extension.dart';

class HomeMenuWidget extends StatelessWidget {

  final List<Widget> children;
  final int indexSep;

  const HomeMenuWidget({super.key, required this.children, required this.indexSep});

  Widget overrideSize(int index, bool invert, Widget child){
    bool s = (index + 1) ~/ 2 == 0;
    if (invert){
      s = !s;
    }
    return AspectRatio(
      aspectRatio: s ? (154 / 230) : 1,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: children.sublist(0, indexSep).mapIndex(
            (e, index) => overrideSize(index, false, e)
          ).toList()
        ).e(),
        Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: children.sublist(indexSep, children.length).mapIndex(
            (e, index) => overrideSize(index, true, e)
          ).toList()
        ).e(),
      ],
    );
  }
}