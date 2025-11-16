import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

class ScheduleWidget {
  static Future<void> init() async {
    await HomeWidget.registerInteractivityCallback(_interactivityCallback);
  }
}

@pragma('vm:entry-point')
Future<void> _interactivityCallback(Uri? uri) async {
  debugPrint("URL = $uri");
  if (uri == null) return;

  final widgetId = uri.queryParameters["id"];
  debugPrint("WIDGET ID = $widgetId");
  if (widgetId == null) return;

  if (uri.host == 'schedule') {
    final action = uri.queryParameters['action'];
    debugPrint("ACTION = $action");
    if (action == 'refresh') {
      await loadSchedule(widgetId);
      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');
    }else if(action == 'test'){
      await loadSchedule(widgetId, "123");
      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');
    }
  }
}

@pragma('vm:entry-point')
Future<void> loadSchedule(String widgetId, [String prefix = ""]) async {
  debugPrint("CALL LOAD SCHEDULE");
  await HomeWidget.saveWidgetData('${widgetId}_group', "Группа А-01-$prefix");
  await HomeWidget.updateWidget(name: 'ScheduleAppWidget');
}