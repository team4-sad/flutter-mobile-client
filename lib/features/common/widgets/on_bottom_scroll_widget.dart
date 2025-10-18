import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/scroll_extension.dart';

class OnBottomScrollWidget extends StatefulWidget {

  final ScrollController controller;
  final Widget child;
  final void Function() onBottom;

  const OnBottomScrollWidget({
    super.key,
    required this.controller,
    required this.child,
    required this.onBottom,
  });

  @override
  State<OnBottomScrollWidget> createState() => _OnBottomScrollWidgetState();
}

class _OnBottomScrollWidgetState extends State<OnBottomScrollWidget> {

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }


  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll(){
    if (widget.controller.isBottom) {
      widget.onBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}