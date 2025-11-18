import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miigaik/features/common/other/app_wrapper_widget.dart';
import 'package:miigaik/features/common/other/di.dart';
import 'package:miigaik/features/root/root_page.dart';
import 'package:miigaik/features/schedule-widget/schedule_widget_configuration_page.dart';
import 'features/schedule-widget/helpers/home_widget_work_manager_helper.dart';
import 'features/schedule-widget/schedule_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel("widget_config");

  int? widgetId;
  try {
    widgetId = await channel.invokeMethod<int>("getWidgetId")
        .timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint("Error getting widget ID: $e");
    await launchApp();
    return;
  }

  if (widgetId == null || widgetId == -1) {
    await launchApp();
  } else {
    await launchWidget(widgetId);
  }
}

Future<void> launchApp() async {
  await EasyLocalization.ensureInitialized();

  HomeWidgetWorkManagerHelper.initializeWorkManager();

  await DI.fullInit();
  await ScheduleWidget.init();

  runApp(MyApp.root());
}

Future<void> launchWidget(int widgetId) async {
  await EasyLocalization.ensureInitialized();

  await DI.homeWidgetInit();
  runApp(MyApp.configurationWidget(widgetId: widgetId));
}

class MyApp extends StatelessWidget {

  final Widget home;

  const MyApp({super.key, required this.home});

  MyApp.root({key}): this(key: key, home: RootPage());
  MyApp.configurationWidget({key, required int widgetId}): this(
    key: key,
    home: ScheduleWidgetConfigurationPage(widgetId: widgetId)
  );

  @override
  Widget build(BuildContext context) {
    return AppWrapperWidget(
      appBuilder: (context, extension) => MaterialApp(
        title: 'MIIGAiK',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: extension.getThemeData(fontFamily: "Roboto"),
        home: home
      )
    );
  }
}
