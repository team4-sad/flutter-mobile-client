import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/schedule/use_case/schedule_use_case.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';

class SaveConfigurationUseCase {
  final FetchScheduleUseCase useCase = FetchScheduleUseCase();
  final IHomeWidgetStorage storage = GetIt.I.get();

  Future<void> call(
    int widgetId,
    SignatureScheduleModel signature,
    DateTime scheduleDate
  ) async {
    await storage.saveSignature(widgetId, signature);
    await storage.saveScheduleDate(widgetId, scheduleDate);

    final scheduleDay = await useCase.call(signature, scheduleDate);
        // .timeout(Duration(seconds: 1));
    final lessons = scheduleDay?.lessons ?? [];
    await storage.saveLessons(widgetId, lessons);
  }
}