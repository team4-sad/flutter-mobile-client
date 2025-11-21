import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/root/tabs/schedule/use_case/schedule_use_case.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';

class RefreshWidgetUseCase {
  final FetchScheduleUseCase useCase;
  final IHomeWidgetStorage storage;

  RefreshWidgetUseCase({required this.useCase, required this.storage});

  Future<bool> call(
    int widgetId, String locale
  ) async {
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
      return true;
    } catch (e) {
      await storage.saveLessons(widgetId, []);
      rethrow;
    }
  }
}