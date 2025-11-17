// workmanager_task.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:workmanager/workmanager.dart';
import 'package:home_widget/home_widget.dart';

// Функция инициализации Workmanager (вызывается из main.dart)
void initializeWorkmanager() {
  Workmanager().initialize(
    callbackDispatcher,
  );
}


final IScheduleRepository repository = GetIt.I.get();

// Функция-обработчик фоновых задач
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("Выполняется фоновая задача: $taskName");

    final dio = Dio(BaseOptions(baseUrl: Config.apiUrl.conf()));
    final apiScheduleRepository = ApiScheduleRepository(dio: dio);

    final widgetId = inputData!['widgetId'];
    final scheduleId = inputData['schedule_id'];
    final scheduleTitle = inputData['schedule_title'];
    final scheduleType = inputData['schedule_type'];
    final isInitial = inputData['isInitial'] ?? false;

    try {
      final response = await apiScheduleRepository.fetchDayGroupSchedule(
          groupId: scheduleId,
          day: DateTime.now()
      );
      List<LessonModel> data = [];
      if (response.schedule.isNotEmpty){
        data = response.schedule.first.lessons;
      }
      await HomeWidget.saveWidgetData(
        '${widgetId}_schedule_size',
        data.length,
      );
      await HomeWidget.saveWidgetData(
        '${widgetId}_schedule_date',
        DateTime.now().eeeeDDmmmm,
      );
      for (int i=0; i<data.length; i++){
        final lesson = data[i];
        await HomeWidget.saveWidgetData(
          '${widgetId}_lessons_${i}_title',
          lesson.disciplineName,
        );
        await HomeWidget.saveWidgetData(
          '${widgetId}_lessons_${i}_start_time',
          lesson.displayStartTime,
        );
        await HomeWidget.saveWidgetData(
          '${widgetId}_lessons_${i}_end_time',
          lesson.displayEndTime,
        );
        await HomeWidget.saveWidgetData(
          '${widgetId}_lessons_${i}_number',
          lesson.lessonOrderNumber,
        );
      }
      await HomeWidget.saveWidgetData(
        '${widgetId}_last_update',
        DateTime.now().toIso8601String(),
      );
      await HomeWidget.saveWidgetData(
        '${widgetId}_schedule_state',
        'loaded',
      );

      // Обновляем виджет
      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');

      print("Фоновая задача завершена успешно для виджета $widgetId");
      return true;

    } catch (e) {
      print("Ошибка в фоновой задаче: $e");

      // Сохраняем состояние ошибки
      await HomeWidget.saveWidgetData(
        '${widgetId}_schedule_state',
        'error',
      );
      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');

      return false;
    }
  });
}