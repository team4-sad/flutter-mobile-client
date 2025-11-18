import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:miigaik/features/common/other/app_wrapper_widget.dart';
import 'package:miigaik/features/common/other/di.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/features/root/root_page.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/root/tabs/schedule/use_case/schedule_use_case.dart';
import 'package:miigaik/features/schedule-widget/schedule_widget_configuration_page.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';
import 'features/config/config.dart';
import 'features/schedule-widget/helpers/home_widget_helper.dart';
import 'features/schedule-widget/helpers/home_widget_work_manager_helper.dart';
import 'features/schedule-widget/use_case/refresh_widget_use_case.dart';


@pragma('vm:entry-point')
Future<void> _interactivityCallback(Uri? uri) async {
  try {
    await dotenv.load(fileName: "config/.env");
    final dio = Dio(BaseOptions(
        baseUrl: Config.apiUrl.conf(),
    ));

    final refreshUseCase = RefreshWidgetUseCase(
      useCase: FetchScheduleUseCase(repo: ApiScheduleRepository(dio: dio)),
      storage: HomeWidgetStorage()
    );

    debugPrint("URL = $uri");
    if (uri == null) return;

    final widgetId = uri.queryParameters["id"];

    debugPrint("WIDGET ID = $widgetId");
    if (widgetId == null) return;

    final locale = uri.queryParameters["locale"] ?? "ru_RU";
    await initializeDateFormatting(locale.toString(), null);
    Intl.defaultLocale = locale.toString();

    if (uri.host == 'schedule') {
      final action = uri.queryParameters['action'];
      debugPrint("ACTION = $action");
      if (action == 'refresh') {
        await refreshUseCase.call(int.parse(widgetId), locale);
        await HomeWidgetHelper.update();
      }
    }
  } on Object catch(e){
    debugPrint(e.toString());
    debugPrintStack(stackTrace: StackTrace.current);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel("widget_config");

  await HomeWidget.registerInteractivityCallback(_interactivityCallback);
  HomeWidgetWorkManagerHelper.initializeWorkManager();

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
  await DI.fullInit();
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
