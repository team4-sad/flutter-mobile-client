import 'package:home_widget/home_widget.dart';

class HomeWidgetHelper {
  static Future<void> update() async {
    await HomeWidget.updateWidget(name: 'ScheduleAppWidget');
  }
}