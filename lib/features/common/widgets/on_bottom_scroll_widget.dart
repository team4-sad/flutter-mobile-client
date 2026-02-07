import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/scroll_extension.dart';

class OnScrollWidget extends StatefulWidget {

  final Widget child;
  final void Function()? onBottom;
  final void Function()? onScroll;
  final void Function()? onNotTop;
  final void Function()? onTop;

  const OnScrollWidget({
    super.key,
    required this.child,
    this.onBottom,
    this.onTop,
    this.onNotTop,
    this.onScroll,
  });

  @override
  State<OnScrollWidget> createState() => _OnScrollWidgetState();
}

class _OnScrollWidgetState extends State<OnScrollWidget> {

  void _onScroll(ScrollMetrics metrics) {
    if (metrics.isBottom && widget.onBottom != null) {
      widget.onBottom!();
    }
    final isNotTop = metrics.pixels > 0;
    if (isNotTop && widget.onNotTop != null) {
      widget.onNotTop!();
    } else if (!isNotTop && widget.onTop != null) {
      widget.onTop!();
    }
    if (widget.onScroll != null) {
      widget.onScroll!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notificationInfo) {
        if (notificationInfo is ScrollNotification) {
          _onScroll(notificationInfo.metrics);
        }
        return true;
      },
      child: widget.child
    );
  }
}