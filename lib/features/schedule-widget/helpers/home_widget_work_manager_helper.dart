import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:workmanager/workmanager.dart';

class HomeWidgetWorkManagerHelper {
  static Future<void> startBackgroundScheduleLoad(
    int widgetId,
    SignatureScheduleModel signature
  ) async {
    await Workmanager().registerOneOffTask(
      'initial_schedule_load_$widgetId',
      'schedule_update_task',
      inputData: {
        'widgetId': widgetId,
        'schedule_id': signature.id,
        'schedule_title': signature.title,
        'schedule_type': signature.type.display,
        'isInitial': true,
      },
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(seconds: 1),
    );
  }

  static Future<void> setupDailyUpdates(
    int widgetId,
    SignatureScheduleModel model
  ) async {
    await Workmanager().registerPeriodicTask(
      'daily_schedule_update_$widgetId',
      'schedule_update_task',
      // frequency: const Duration(minutes: 1),
      frequency: const Duration(seconds: 5),
      inputData: {
        'widgetId': widgetId,
        'schedule_id': model.id,
        'schedule_title': model.title,
        'schedule_type': model.type.display,
      },
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(seconds: 10),
    );
  }
}