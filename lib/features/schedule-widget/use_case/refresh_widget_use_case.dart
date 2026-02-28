import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:miigaik/features/root/tabs/schedule/use_case/fetch_schedule_use_case.dart';
import 'package:miigaik/features/schedule-widget/helpers/home_widget_helper.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';

class RefreshWidgetUseCase {
  final FetchScheduleUseCase useCase;
  final IHomeWidgetStorage storage;

  RefreshWidgetUseCase({required this.useCase, required this.storage});

  Future<bool> call(
    int widgetId, String locale
  ) async {
    await storage.setRefresh(widgetId, true);
    await HomeWidgetHelper.update();
    for (int i = 0; i<5; i++){
      try {
        final strWidgetDate = await storage.getDate(widgetId);
        final widgetDate = DateTime.parse(strWidgetDate);
        final currentDate = DateTime.now();

        final widgetSignature = await storage.getSignature(widgetId);

        if (widgetDate == currentDate){
          return true;
        }

        await storage.saveLocale(locale);

        try {
          final schedule = await useCase.call(widgetSignature, currentDate);
          final lessons = schedule?.lessons ?? [];
          await storage.saveScheduleDate(widgetId, currentDate);
          await storage.saveLessons(widgetId, lessons);
          await storage.setRefresh(widgetId, false);
          await HomeWidgetHelper.update();
          return true;
        } catch (e) {
          await storage.saveLessons(widgetId, []);
          await HomeWidgetHelper.update();
          rethrow;
        }
      } on DioException catch(e) {
        debugPrint("Попытка ${i + 1}/5 обновить расписание не удачна: ${e
            .toString()}");
        continue;
      }
    }
    return false;
  }
}