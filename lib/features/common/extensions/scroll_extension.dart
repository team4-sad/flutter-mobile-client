import 'package:flutter/cupertino.dart';

extension ScrollExtension on ScrollController {
  bool get isBottom {
    if (!hasClients) return false;
    final maxScroll = position.maxScrollExtent;
    final current = offset;
    return current >= (maxScroll * 0.95);
  }
}

extension ScrollMetricsExtension on ScrollMetrics {
  bool get isBottom {
    final maxScroll = maxScrollExtent;
    final current = pixels;
    return current >= (maxScroll * 0.95);
  }
}