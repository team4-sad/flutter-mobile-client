import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miigaik/features/common/extensions/package_info_extension.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/features/network-connection/bloc/network_connection_bloc.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/root/root_page.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_list_bloc/news_list_bloc.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_page_mode_bloc/news_page_mode_bloc.dart';
import 'package:miigaik/features/root/tabs/news/bloc/search_news_bloc/search_news_bloc.dart';
import 'package:miigaik/features/root/tabs/news/repository/news_repository.dart';
import 'package:miigaik/features/root/tabs/news/repository/search_news_repository.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_day_bloc/current_day_bloc.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/repository/signature_schedule_repository.dart';
import 'package:miigaik/features/single-news/bloc/single_news_bloc.dart';
import 'package:miigaik/features/single-news/repository/single_news_repository.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/theme/app_theme.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'features/common/other/http_override.dart';
import 'features/config/config.dart';
import 'features/root/features/bottom-nav-bar/bloc/bottom_nav_bar_bloc.dart';
import 'features/root/features/bottom-nav-bar/items_nav_bar.dart';
import 'features/switch-theme/theme_bloc.dart';

void main() async {
  await dotenv.load(fileName: "config/.env");

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  BadCertificateHttpOverrides.setup();

  await Hive.initFlutter();
  Hive.registerAdapter(SignatureScheduleModelAdapter());
  Hive.registerAdapter(SignatureScheduleTypeAdapter());

  final boxSignaturesSchedules = await Hive.openBox<SignatureScheduleModel>(
    "box_for_signatures_schedules"
  );
  final signatureScheduleRepository = SignatureScheduleRepository(box: boxSignaturesSchedules);
  GetIt.I.registerSingleton(signatureScheduleRepository);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton(packageInfo);

  final talker = Talker();
  GetIt.I.registerSingleton(talker);
  Bloc.observer = TalkerBlocObserver(talker: talker);

  final networkConnectionService = NetworkConnectionService();
  await networkConnectionService.launch();
  GetIt.I.registerSingleton(networkConnectionService);

  final dio = Dio(BaseOptions(baseUrl: Config.apiUrl.conf()));
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(),
    ),
  );

  final INewsRepository apiNewsRepository = ApiNewsRepository(dio: dio);
  GetIt.I.registerSingleton(apiNewsRepository);

  final ISingleNewsRepository apiSingleNewsRepository = ApiSingleNewsRepository(dio: dio);
  GetIt.I.registerSingleton(apiSingleNewsRepository);

  final ISearchNewsRepository apiSearchNewsRepository = ApiSearchNewsRepository(dio: dio);
  GetIt.I.registerSingleton(apiSearchNewsRepository);

  GetIt.I.registerSingleton(ThemeBloc(AppTheme.defaultTheme()));
  GetIt.I.registerSingleton(BottomNavBarBloc(ItemNavBar.defaultItem()));
  GetIt.I.registerSingleton(NetworkConnectionBloc()..listen());
  GetIt.I.registerSingleton(NewsListBloc());
  GetIt.I.registerSingleton(SingleNewsBloc());
  GetIt.I.registerSingleton(NewsSearchBloc());
  GetIt.I.registerSingleton(NewsPageModeBloc());
  GetIt.I.registerSingleton(SignatureScheduleBloc());
  GetIt.I.registerSingleton(CurrentDayBloc());

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale("ru")],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!GetIt.I.isRegistered<LocaleBloc>()){
      GetIt.I.registerSingleton(LocaleBloc(
        context.supportedLocales,
        context.locale
      ));
    }

    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: GetIt.I.get<ThemeBloc>(),
      builder: (context, state) {
        final appThemeExtension = AppThemeExtension.fromAppTheme(
            state.appTheme
        );
        return ScreenUtilInit(
          designSize: const Size(360, 750),
          builder: (context, child){
            return MaterialApp(
              title: 'MIIGAiK',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: appThemeExtension.getThemeData(
                fontFamily: "Roboto"
              ),
              home: Stack(children: [
                ?child,
                if (kDebugMode)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(top: 55, right: 50),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Banner(
                          message: GetIt.I.get<PackageInfo>().fullVersion,
                          location: BannerLocation.bottomStart,
                        ),
                      ),
                    ),
                  ),
              ])
            );
          },
          child: BlocBuilder<LocaleBloc, LocaleState>(
            bloc: GetIt.I.get<LocaleBloc>(),
            builder: (context, state) {
              context.setLocale(state.locale);
              return RootPage();
            },
          )
        );
      },
    );
  }
}