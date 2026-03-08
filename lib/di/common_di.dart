import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as cache_manager;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miigaik/config/config.dart';
import 'package:miigaik/core/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/core/other/cache_helper.dart';
import 'package:miigaik/core/other/http_override.dart';
import 'package:miigaik/features/notes/models/note_model.dart';
import 'package:miigaik/features/profile/storages/session_storage.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/settings/bloc/switch-locale/locale_bloc.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../core/other/dio_auth_interceptor.dart';

class CommonDI {
  static const String miigaikApiDioName = "miigaik_api_dio";

  static Future<void> register() async {
    await registerHive();
    registerCache();
    registerLogger();
    registerDio();
    registerServices();
  }

  static void registerLogger() {
    GetIt.I.registerSingleton(Talker());
  }

  static void registerDio() {
    BadCertificateHttpOverrides.setup();

    final sessionStorage = SessionStorageImpl(secureStorage: GetIt.I.get());
    GetIt.I.registerSingleton(sessionStorage);

    final dio = Dio(BaseOptions(baseUrl: Config.apiUrl));
    dio.interceptors.addAll([
        DioAuthInterceptor(
          storage: sessionStorage
        ),
        TalkerDioLogger(
          talker: GetIt.I.get(),
          settings: TalkerDioLoggerSettings(
            printErrorMessage: true,
            printErrorData: true,
            printErrorHeaders: true,
            errorFilter: (e) {
              return true;
            }
          ),
        ),
      ]
    );
    GetIt.I.registerSingleton(dio);

    final scheduleApiDio = Dio(
      BaseOptions(baseUrl: Config.scheduleApiUrl),
    );
    scheduleApiDio.interceptors.add(
      TalkerDioLogger(
        talker: GetIt.I.get(),
        settings: const TalkerDioLoggerSettings(),
      ),
    );
    GetIt.I.registerSingleton(scheduleApiDio, instanceName: miigaikApiDioName);
  }

  static Future<void> registerServices() async {
    final networkConnectionService = NetworkConnectionService();
    await networkConnectionService.launch();
    GetIt.I.registerSingleton(networkConnectionService);
  }

  static Future<void> registerHive() async {
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

  static Future<void> registerCache() async {
    GetIt.I.registerSingleton(CacheHelper(cacheManager: cache_manager.CacheManager(
      cache_manager.Config(
        "miigaik_cache",
        stalePeriod: const Duration(hours: 1)
      )
    )));
    
    GetIt.I.registerSingleton(FlutterSecureStorage());
    GetIt.I.registerSingleton<SessionStorage>(SessionStorageImpl());
  }

  static void registerLocaleBloc(BuildContext context) {
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