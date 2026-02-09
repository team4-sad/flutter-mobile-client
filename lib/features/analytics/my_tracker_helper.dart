import 'package:appmetrica_plugin/appmetrica_plugin.dart';

class MyTrackerHelper {
  // TODO: Вынести в аргументы запуска приложения
  static const String apiKey = "1d04e355-d85d-4d76-86bb-341a5bcb1af1";

  static Future<void> init(String userId) async {
    AppMetrica.runZoneGuarded(() async {
      await AppMetrica.activate(AppMetricaConfig(apiKey, logs: true));
    });
  }
}