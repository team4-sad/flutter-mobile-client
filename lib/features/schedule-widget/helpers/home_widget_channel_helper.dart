import 'package:flutter/services.dart';

class HomeWidgetChannelHelper {
  static Future<void> finish() async {
    await MethodChannel("widget_config").invokeMethod("finish");
  }

  static Future<void> cancel() async {
    await MethodChannel("widget_config").invokeMethod("cancel");
  }
}