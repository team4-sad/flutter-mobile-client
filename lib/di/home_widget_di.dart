import 'package:get_it/get_it.dart';
import 'package:miigaik/features/network-connection/bloc/network_connection_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/repository/signature_schedule_repository.dart';
import 'package:miigaik/features/schedule-widget/storage/home_widget_storage.dart';
import 'package:miigaik/features/switch-theme/theme_bloc.dart';
import 'package:miigaik/theme/app_theme.dart';

class HomeWidgetDI {
  static Future<void> register() async {
    registerRepositories();
    registerStorages();
    registerBlocs();
  }

  static void registerRepositories() {
    final apiScheduleRepository = ApiScheduleRepository(dio: GetIt.I.get());
    GetIt.I.registerSingleton<IScheduleRepository>(apiScheduleRepository);

    final signatureScheduleRepository = SignatureScheduleRepository(
      box: GetIt.I.get(),
    );
    GetIt.I.registerSingleton<ISignatureScheduleRepository>(
      signatureScheduleRepository,
    );
  }

  static void registerBlocs(){
    GetIt.I.registerSingleton(ThemeBloc(AppTheme.defaultTheme()));
    GetIt.I.registerSingleton(NetworkConnectionBloc()..listen());
    GetIt.I.registerSingleton(SignatureScheduleBloc());
  }

  static void registerStorages(){
    final homeWidgetStorage = HomeWidgetStorage();
    GetIt.I.registerSingleton<IHomeWidgetStorage>(homeWidgetStorage);
  }
}