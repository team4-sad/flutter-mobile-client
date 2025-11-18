import 'dart:async';
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/schedule/use_case/schedule_use_case.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';

import '../enum/schedule_state.dart';

class SaveConfigurationUseCase {
  final FetchScheduleUseCase useCase = FetchScheduleUseCase();
  final IHomeWidgetStorage storage = GetIt.I.get();

  Future<bool> call(
    int widgetId,
    SignatureScheduleModel signature,
    DateTime scheduleDate,
    Locale locale
  ) async {
    await storage.saveSignature(widgetId, signature);
    await storage.saveScheduleDate(widgetId, scheduleDate);

    try {
      final scheduleDay = await useCase.call(signature, scheduleDate)
          .timeout(const Duration(seconds: 3));

      final lessons = scheduleDay?.lessons ?? [];
      await storage.saveLessons(widgetId, lessons);
      await storage.saveScheduleState(widgetId, ScheduleState.loaded);

      return true;
    } on TimeoutException {
      await storage.saveScheduleState(widgetId, ScheduleState.loading);
      await storage.saveLessons(widgetId, []);
      return false;
    } catch (e) {
      await storage.saveScheduleState(widgetId, ScheduleState.error);
      await storage.saveLessons(widgetId, []);
      rethrow;
    }
  }
}