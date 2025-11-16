import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

class ScheduleWidgetConfigurationPage extends StatefulWidget {

  final int widgetId;

  const ScheduleWidgetConfigurationPage({super.key, required this.widgetId});

  @override
  State<ScheduleWidgetConfigurationPage> createState() => _ScheduleWidgetConfigurationPageState();
}

class _ScheduleWidgetConfigurationPageState extends State<ScheduleWidgetConfigurationPage> {
  final TextEditingController controller = TextEditingController();
  bool _isLoading = false;

  Future<void> save() async {
    if (controller.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await HomeWidget.saveWidgetData(
        '${widget.widgetId}_group',
        controller.text,
      );

      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');

      await MethodChannel("widget_config").invokeMethod("finish");
    } catch (e) {
      debugPrint("Error saving widget: $e");
      await MethodChannel("widget_config").invokeMethod("finish");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: save,
              child: Text("Сохранить"),
            )
          ],
        ),
      ),
    );
  }
}