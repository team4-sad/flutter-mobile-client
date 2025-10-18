import 'package:flutter/cupertino.dart';

extension ScrollExtension on ScrollController {
  bool get isBottom {
    if (!hasClients) return false;
    final maxScroll = position.maxScrollExtent;
    final current = offset;
    // срабатывает чуть раньше конца
    return current >= (maxScroll * 0.95);
  }
}