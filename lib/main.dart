import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/other/di.dart';
import 'package:miigaik/features/root/root_page.dart';
import 'package:miigaik/features/schedule-widget/schedule_widget_configuration_page.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'features/schedule-widget/schedule_widget.dart';
import 'features/switch-theme/theme_bloc.dart';

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

class WidgetMyApp extends StatelessWidget {
  final int widgetId;

  const WidgetMyApp({super.key, required this.widgetId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScheduleWidgetConfigurationPage(widgetId: widgetId),
      ),
    );
  }
}

Future<void> launchApp() async {
  await EasyLocalization.ensureInitialized();

  await DI.fullInit();
  await ScheduleWidget.init();

  runApp(const MyApp());
}

Future<void> launchWidget(int widgetId) async {
  runApp(WidgetMyApp(widgetId: widgetId));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [Locale('en'), Locale("ru")],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: GetIt.I.get<ThemeBloc>(),
        builder: (context, state) {
          DI.safeInitWithContext(context);
          final appThemeExtension = AppThemeExtension.fromAppTheme(
            state.appTheme,
          );
          return ScreenUtilInit(
            designSize: const Size(360, 750),
            builder: (context, child) {
              return MaterialApp(
                title: 'MIIGAiK',
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: appThemeExtension.getThemeData(fontFamily: "Roboto"),
                home: child
              );
            },
            child: BlocBuilder<LocaleBloc, LocaleState>(
              bloc: GetIt.I.get<LocaleBloc>(),
              builder: (context, state) {
                context.setLocale(state.locale);
                return RootPage();
              },
            ),
          );
        },
      ),
    );
  }
}
