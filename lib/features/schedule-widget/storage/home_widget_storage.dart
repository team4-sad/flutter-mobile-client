import 'dart:convert';
import 'dart:ui';

import 'package:home_widget/home_widget.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/extensions/string_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

import '../enum/schedule_state.dart';

abstract class IHomeWidgetStorage {
  Future<void> saveSignature(
    int widgetId,
    SignatureScheduleModel signature,
  );
  Future<void> saveLessons(
    int widgetId,
    List<LessonModel> lessons,
  );
  Future<void> saveScheduleDate(
    int widgetId,
    DateTime scheduleDate
  );
  Future<String> getDate(
    int widgetId,
  );
  Future<void> saveScheduleState(
    int widgetId,
    ScheduleState state
  );
  Future<bool> checkWidgetIsExist(
    int widgetId
  );
}

class HomeWidgetStorage extends IHomeWidgetStorage {
  @override
  Future<void> saveSignature(
      int widgetId,
      SignatureScheduleModel signature,
      ) async {
    final mapSignature = signature.toMap();
    final stringSignature = jsonEncode(mapSignature);
    await HomeWidget.saveWidgetData("${widgetId}_signature", stringSignature);
  }

  @override
  Future<void> saveLessons(
      int widgetId,
      List<LessonModel> lessons,
      ) async {
    final listOfMaps = lessons.map((e) => e.toMap()).toList();
    final stringLessons = jsonEncode(listOfMaps);
    await HomeWidget.saveWidgetData("${widgetId}_lessons", stringLessons);
    await HomeWidget.saveWidgetData("${widgetId}_lessons_empty", lessons.isEmpty);
  }

  @override
  Future<void> saveScheduleDate(
    int widgetId,
    DateTime scheduleDate
  ) async {
    final stringDate = scheduleDate.yyyyMMdd;
    await HomeWidget.saveWidgetData("${widgetId}_date", stringDate);

    final stringDisplayDate = scheduleDate.eeeeDDmmmm.title;
    await HomeWidget.saveWidgetData("${widgetId}_display_date", stringDisplayDate);
  }

  @override
  Future<void> saveScheduleState(int widgetId, ScheduleState state) async {
    await HomeWidget.saveWidgetData("${widgetId}_schedule_state",  state.value);
  }

  @override
  Future<String> getDate(int widgetId) async {
    return await HomeWidget.getWidgetData("${widgetId}_date");
  }

  @override
  Future<bool> checkWidgetIsExist(int widgetId) async {
    final allWidgets = await HomeWidget.getInstalledWidgets();
    return allWidgets.any((e) => e.androidWidgetId == widgetId);
  }
}