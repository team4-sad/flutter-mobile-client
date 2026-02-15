import 'package:appmetrica_plugin/appmetrica_plugin.dart';

class AnalyticHelper {
  static bool isInit = false;

  static void init(String apiKey) {
    if (apiKey == ""){
      return;
    }
    AppMetrica.runZoneGuarded(() async {
      await AppMetrica.activate(AppMetricaConfig(apiKey, logs: true));
      isInit = true;
    });
  }
}