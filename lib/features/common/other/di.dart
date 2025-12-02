import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miigaik/features/add-schedule/repository/signature_schedule_repository.dart';
import 'package:miigaik/features/common/other/http_override.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/features/network-connection/bloc/network_connection_bloc.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/items_nav_bar.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_list_bloc/news_list_bloc.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_page_mode_bloc/news_page_mode_bloc.dart';
import 'package:miigaik/features/root/tabs/news/bloc/search_news_bloc/search_news_bloc.dart';
import 'package:miigaik/features/root/tabs/news/repository/news_repository.dart';
import 'package:miigaik/features/root/tabs/news/repository/search_news_repository.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/notes_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/repository/notes_repository.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_time_cubit/current_time_cubit.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_selected_day_bloc/schedule_selected_day_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/repository/signature_schedule_repository.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';
import 'package:miigaik/features/single-news/bloc/single_news_bloc.dart';
import 'package:miigaik/features/single-news/repository/single_news_repository.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/features/switch-theme/theme_bloc.dart';
import 'package:miigaik/theme/app_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DI {
  static const String defaultDioName = "default_dio";
  static const String miigaikApiDioName = "miigaik_api_dio";

  static Future<void> fullInit() async {
    initLogger();
    await initPackageInfo();
    await initConfig();
    await initHive();
    initDio();
    initRepositories();
    initStorages();
    await initServices();
    initBlocs();
  }

  static Future<void> homeWidgetInit() async {
    initLogger();
    await initConfig();
    await initHive();
    initDio();
    initRepositoriesHomeWidget();
    initStorages();
    await initServices();
    initBlocsHomeWidget();
  }

  static Future<void> initConfig() async {
    return await dotenv.load(fileName: "config/.env");
  }

  static Future<void> initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    GetIt.I.registerSingleton(packageInfo);
  }

  static void initRepositoriesHomeWidget(){
    final defaultDio = GetIt.I.get<Dio>(instanceName: defaultDioName);

    final apiScheduleRepository = ApiScheduleRepository(dio: defaultDio);
    GetIt.I.registerSingleton<IScheduleRepository>(apiScheduleRepository);

    final signatureScheduleRepository = SignatureScheduleRepository(
      box: GetIt.I.get(),
    );
    GetIt.I.registerSingleton<ISignatureScheduleRepository>(
      signatureScheduleRepository,
    );
  }

  static void initRepositories() {
    final signatureScheduleRepository = SignatureScheduleRepository(
      box: GetIt.I.get(),
    );
    GetIt.I.registerSingleton<ISignatureScheduleRepository>(
      signatureScheduleRepository,
    );

    final defaultDio = GetIt.I.get<Dio>(instanceName: defaultDioName);
    // final miigaikApiDio = GetIt.I.get<Dio>(instanceName: miigaikApiDioName);

    final apiNewsRepository = ApiNewsRepository(dio: defaultDio);
    GetIt.I.registerSingleton<INewsRepository>(apiNewsRepository);

    final apiSingleNewsRepository = ApiSingleNewsRepository(dio: defaultDio);
    GetIt.I.registerSingleton<ISingleNewsRepository>(apiSingleNewsRepository);

    final apiSearchNewsRepository = ApiSearchNewsRepository(dio: defaultDio);
    GetIt.I.registerSingleton<ISearchNewsRepository>(apiSearchNewsRepository);

    final apiScheduleRepository = ApiScheduleRepository(dio: defaultDio);
    GetIt.I.registerSingleton<IScheduleRepository>(apiScheduleRepository);

    final apiSignaturesRepository = ApiSignatureScheduleRepository(dio: defaultDio);
    GetIt.I.registerSingleton<INewSignatureScheduleRepository>(
      apiSignaturesRepository,
    );

    final notesRepository = NotesRepository();
    GetIt.I.registerSingleton<INotesRepository>(notesRepository);
  }

  static void initBlocsHomeWidget(){
    GetIt.I.registerSingleton(ThemeBloc(AppTheme.defaultTheme()));
    GetIt.I.registerSingleton(NetworkConnectionBloc()..listen());
    GetIt.I.registerSingleton(SignatureScheduleBloc());
  }

  static void initBlocs() {
    GetIt.I.registerSingleton(ThemeBloc(AppTheme.defaultTheme()));
    GetIt.I.registerSingleton(BottomNavBarBloc(ItemNavBar.defaultItem()));
    GetIt.I.registerSingleton(NetworkConnectionBloc()..listen());
    GetIt.I.registerSingleton(NewsListBloc());
    GetIt.I.registerSingleton(SingleNewsBloc());
    GetIt.I.registerSingleton(NewsSearchBloc());
    GetIt.I.registerSingleton(NewsPageModeBloc());
    GetIt.I.registerSingleton(SignatureScheduleBloc());
    GetIt.I.registerSingleton(ScheduleSelectedDayBloc());
    GetIt.I.registerSingleton(ScheduleBloc());
    GetIt.I.registerSingleton(NotesBloc());

    GetIt.I.registerSingleton(CurrentTimeCubit());
  }

  static Future<void> initServices() async {
    final networkConnectionService = NetworkConnectionService();
    await networkConnectionService.launch();
    GetIt.I.registerSingleton(networkConnectionService);
  }

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SignatureScheduleModelAdapter());
    Hive.registerAdapter(SignatureScheduleTypeAdapter());
    Hive.registerAdapter(NoteModelAdapter());

    final boxSignaturesSchedules = await Hive.openBox<SignatureScheduleModel>(
      "box_for_signatures_schedules",
    );
    GetIt.I.registerSingleton(boxSignaturesSchedules);

    final boxNotes = await Hive.openBox<NoteModel>("box_for_notes");
    GetIt.I.registerSingleton(boxNotes);
  }

  static void initLogger() {
    final talker = Talker();
    GetIt.I.registerSingleton(talker);
  }

  static void initDio() {
    BadCertificateHttpOverrides.setup();

    final dio = Dio(BaseOptions(baseUrl: Config.apiUrl.conf()));
    dio.interceptors.add(
      TalkerDioLogger(
        talker: GetIt.I.get(),
        settings: const TalkerDioLoggerSettings(),
      ),
    );
    GetIt.I.registerSingleton(dio, instanceName: defaultDioName);

    // TODO: Надо переехать на нашу апи
    final scheduleApiDio = Dio(
      BaseOptions(baseUrl: Config.scheduleApiUrl.conf()),
    );
    scheduleApiDio.interceptors.add(
      TalkerDioLogger(
        talker: GetIt.I.get(),
        settings: const TalkerDioLoggerSettings(),
      ),
    );
    GetIt.I.registerSingleton(scheduleApiDio, instanceName: miigaikApiDioName);
  }

  static void initStorages(){
    final homeWidgetStorage = HomeWidgetStorage();
    GetIt.I.registerSingleton<IHomeWidgetStorage>(homeWidgetStorage);
  }

  static void safeInitWithContext(BuildContext context) {
    if (!context.mounted) {
      return;
    }
    if (!GetIt.I.isRegistered<LocaleBloc>()) {
      GetIt.I.registerSingleton(
        LocaleBloc(context.supportedLocales, context.locale),
      );
    }
  }
}
