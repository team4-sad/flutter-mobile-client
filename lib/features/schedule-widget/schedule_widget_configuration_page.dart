import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

class ScheduleWidgetConfigurationPage extends StatelessWidget {

  final int widgetId;

  ScheduleWidgetConfigurationPage({super.key, required this.widgetId});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Настройка виджета")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Введите группу"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: Text("Сохранить"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> save() async {
    if (controller.text.isEmpty) return;

    try {
      await HomeWidget.saveWidgetData(
        '${widgetId}_group',
        controller.text,
      );

      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');

      await MethodChannel("widget_config").invokeMethod("finish");
    } catch (e) {
      debugPrint("Error saving widget: $e");
      await MethodChannel("widget_config").invokeMethod("finish");
    }
  }
}