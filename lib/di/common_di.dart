import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miigaik/features/common/other/http_override.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CommonDI {
  static const String miigaikApiDioName = "miigaik_api_dio";

  static Future<void> register() async {
    await registerHive();
    registerLogger();
    registerDio();
    registerServices();
  }

  static void registerLogger() {
    GetIt.I.registerSingleton(Talker());
  }

  static void registerDio() {
    BadCertificateHttpOverrides.setup();

    final dio = Dio(BaseOptions(baseUrl: Config.apiUrl));
    dio.interceptors.add(
      TalkerDioLogger(
        talker: GetIt.I.get(),
        settings: const TalkerDioLoggerSettings(),
      ),
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