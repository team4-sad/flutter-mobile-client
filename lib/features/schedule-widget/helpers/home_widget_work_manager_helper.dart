import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/root/tabs/schedule/use_case/schedule_use_case.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-widget/enum/schedule_state.dart';
import 'package:miigaik/features/schedule-widget/helpers/home_widget_helper.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';
import 'package:workmanager/workmanager.dart';

class HomeWidgetWorkManagerHelper {
  static Future<void> startBackgroundScheduleLoad(
    int widgetId,
    SignatureScheduleModel signature,
    Locale locale,
  ) async {
    final uniqueName = 'initial_schedule_load_$widgetId';
    debugPrint("Попытка регистрации фоновой задачи $uniqueName");
    final isAlreadyHas = await Workmanager().isScheduledByUniqueName(uniqueName);
    if (isAlreadyHas){
      debugPrint("Фоновая задача $uniqueName уже зарегистрирована");
      return;
    }
    await Workmanager().registerOneOffTask(
      'initial_schedule_load_$widgetId',
      'schedule_update_task',
      inputData: {
        'widgetId': widgetId,
        'uniqueName': uniqueName,
        'countryCode':  locale.countryCode,
        'locale': locale.languageCode,
        'signature': jsonEncode(signature.toMap()),
        'isInitial': true,
      },
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(seconds: 1),
    );
    debugPrint("Фоновая задача $uniqueName зарегистрирована");
  }

  static Future<void> setupDailyUpdates(
    int widgetId,
    SignatureScheduleModel signature,
    Locale locale,
  ) async {
    final uniqueName = 'daily_schedule_update_${widgetId}_${DateTime.now().millisecondsSinceEpoch}';
    await Workmanager().registerOneOffTask(
      uniqueName,
      'schedule_update_task',
      inputData: {
        'widgetId': widgetId,
        'uniqueName': uniqueName,
        'countryCode':  locale.countryCode,
        'locale': locale.languageCode,
        'signature': jsonEncode(signature.toMap()),
      },
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(minutes: 10),
    );
  }

  static void initializeWorkManager() {
    Workmanager().initialize(
      callbackDispatcher
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    debugPrint("Выполняется фоновая задача: $taskName");

    final widgetId = inputData!['widgetId'];
    final uniqueName = inputData['uniqueName'];
    final localeCode = inputData['locale'] ?? 'ru';
    final countryCode = inputData['countryCode'] ?? 'RU';
    final signatureString = inputData['signature'];

    final locale = Locale(localeCode, countryCode);

    final signature = SignatureScheduleModel.fromMap(jsonDecode(signatureString));

    HomeWidgetWorkManagerHelper.setupDailyUpdates(
      widgetId, signature, locale
    );

    final storage = HomeWidgetStorage();

    if (!await storage.checkWidgetIsExist(widgetId)) {
      debugPrint("Widget $widgetId no longer exists, cancelling task");
      await Workmanager().cancelByUniqueName(uniqueName);
      return false;
    }

    final widgetStringDate = await storage.getDate(widgetId);
    final widgetDate = DateTime.parse(widgetStringDate);
    final nowDate = DateTime.now();
    
    if (widgetDate == nowDate){
      return true;
    }
    
    debugPrint("Фоновая задача допущена для обновления widgetId=$widgetId");
    try {
      await initializeDateFormatting(locale.toString(), null);
      Intl.defaultLocale = locale.toString();
      await dotenv.load(fileName: "config/.env");
      debugPrint(Config.apiUrl.conf());
      final dio = Dio(BaseOptions(baseUrl: Config.apiUrl.conf()));
      final apiScheduleRepository = ApiScheduleRepository(dio: dio);
      final useCase = FetchScheduleUseCase(repo: apiScheduleRepository);

      final response = await useCase.call(signature, nowDate);
      await storage.saveLessons(widgetId, response?.lessons ?? []);
      await storage.saveScheduleDate(widgetId, nowDate);
      await storage.saveScheduleState(widgetId, ScheduleState.loaded);
      await HomeWidgetHelper.update();
      debugPrint("Фоновая задача завершена успешно для виджета $widgetId");
      return true;
    } catch (e) {
      debugPrint("Ошибка в фоновой задаче $taskName для виджета $widgetId: $e");
      debugPrint("Stacktrace: ${StackTrace.current}");
      await storage.saveScheduleState(widgetId, ScheduleState.error);
      await HomeWidgetHelper.update();
      return false;
    }
  });
}