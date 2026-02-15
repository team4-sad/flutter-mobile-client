import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

class AnalyticHelper {
  static bool isInit = false;

  static void init(String apiKey, [bool showLogs=true]) {
    if (apiKey == ""){
      return;
    }
    AppMetrica.runZoneGuarded(() async {
      await AppMetrica.activate(
        AppMetricaConfig(
          apiKey,
          logs: showLogs,
          maxReportsCount: 3
        ),
      );
      isInit = true;
    });
  }

  static void push(){
    AppMetrica.sendEventsBuffer();
  }

  static void eventCreatedNote(){
    if (!isInit){
      return;
    }
    AppMetrica.reportEvent("CREATED_NOTE");
  }

  static void eventOpenSingleNews(String newsId){
    if (!isInit){
      return;
    }
    AppMetrica.reportEventWithMap("OPEN_SINGLE_NEWS", {
      "news_id": newsId
    });
  }

  static void eventShowNotTodaySchedule(SignatureScheduleModel signature){
    if (!isInit){
      return;
    }
    AppMetrica.reportEventWithMap("SHOW_NOT_TODAY_SCHEDULE", signature.toMap());
  }
}