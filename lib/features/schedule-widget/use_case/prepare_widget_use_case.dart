import 'dart:async';
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/schedule/use_case/fetch_schedule_use_case.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';

class PrepareWidgetUseCase {
  final FetchScheduleUseCase useCase = FetchScheduleUseCase();
  final IHomeWidgetStorage storage = GetIt.I.get();

  Future<bool> call(
    int widgetId,
    SignatureScheduleModel signature,
    DateTime scheduleDate,
    String locale
  ) async {
    await storage.saveLocale(locale);
    await storage.saveSignature(widgetId, signature);
    await storage.saveScheduleDate(widgetId, scheduleDate);
    try {
      final scheduleDay = await useCase.call(signature, scheduleDate);
      final lessons = scheduleDay?.lessons ?? [];
      await storage.saveLessons(widgetId, lessons);
      return true;
    } catch (e) {
      await storage.saveLessons(widgetId, []);
      rethrow;
    }
  }
}