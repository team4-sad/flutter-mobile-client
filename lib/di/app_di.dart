import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/add-schedule/repository/signature_schedule_repository.dart';
import 'package:miigaik/features/network-connection/bloc/network_connection_bloc.dart';
import 'package:miigaik/features/note/repositories/attachment_repository.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/items_nav_bar.dart';
import 'package:miigaik/features/root/tabs/map/bloc/floor_map_cubit/floor_map_cubit.dart';
import 'package:miigaik/features/root/tabs/map/bloc/map_cubit/map_cubit.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_list_bloc/news_list_bloc.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_page_mode_bloc/news_page_mode_bloc.dart';
import 'package:miigaik/features/root/tabs/news/bloc/search_news_bloc/search_news_bloc.dart';
import 'package:miigaik/features/root/tabs/news/repository/news_repository.dart';
import 'package:miigaik/features/root/tabs/news/repository/search_news_repository.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/notes_bloc/notes_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/notes_mode_cubit/notes_mode_cubit.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/search_notes_bloc/search_notes_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/repository/notes_repository.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_time_cubit/current_time_cubit.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_selected_day_bloc/schedule_selected_day_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/schedule-choose/bloc/selecting_schedule_choose_page_cubit/selecting_schedule_choose_page_cubit.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/repository/signature_schedule_repository.dart';
import 'package:miigaik/features/single-news/repository/single_news_repository.dart';
import 'package:miigaik/features/switch-theme/theme_bloc.dart';
import 'package:miigaik/theme/app_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDI {
  static Future<void> register() async {
    await registerPackageInfo();
    registerRepositories();
    registerBlocs();
  }

  static Future<void> registerPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    GetIt.I.registerSingleton(packageInfo);
  }

  static void registerRepositories() {
    final signatureScheduleRepository = SignatureScheduleRepository(
      box: GetIt.I.get(),
    );
    GetIt.I.registerSingleton<ISignatureScheduleRepository>(
      signatureScheduleRepository,
    );

    final defaultDio = GetIt.I.get<Dio>();

    final apiNewsRepository = ApiNewsRepository(dio: defaultDio);
    GetIt.I.registerSingleton<INewsRepository>(apiNewsRepository);

    final apiSingleNewsRepository = ApiSingleNewsRepository(dio: defaultDio);
    GetIt.I.registerSingleton<ISingleNewsRepository>(apiSingleNewsRepository);

    final apiSearchNewsRepository = ApiSearchNewsRepository(dio: defaultDio);
    GetIt.I.registerSingleton<ISearchNewsRepository>(apiSearchNewsRepository);

    final cachedApiScheduleRepository = CachedApiScheduleRepository(
      dio: defaultDio,
      cacheHelper: GetIt.I.get()
    );
    GetIt.I.registerSingleton<IScheduleRepository>(cachedApiScheduleRepository, instanceName: "cached");

    final apiScheduleRepository = ApiScheduleRepository(
      dio: defaultDio,
    );
    GetIt.I.registerSingleton<IScheduleRepository>(apiScheduleRepository);

    final apiSignaturesRepository = ApiNewSignatureScheduleRepository(dio: defaultDio);
    GetIt.I.registerSingleton<INewSignatureScheduleRepository>(
      apiSignaturesRepository,
    );

    final notesRepository = NotesRepository(box: GetIt.I.get());
    GetIt.I.registerSingleton<INotesRepository>(notesRepository);

    final noteAttachmentRepository = NoteAttachmentRepository();
    GetIt.I.registerSingleton<INoteAttachmentRepository>(noteAttachmentRepository);
  }

  static void registerBlocs() {
    GetIt.I.registerSingleton(ThemeBloc(AppTheme.defaultTheme()));
    GetIt.I.registerSingleton(BottomNavBarBloc(ItemNavBar.defaultItem()));
    GetIt.I.registerSingleton(NetworkConnectionBloc()..listen());
    GetIt.I.registerSingleton(NewsListBloc());
    GetIt.I.registerSingleton(NewsSearchBloc());
    GetIt.I.registerSingleton(NewsPageModeBloc());
    GetIt.I.registerSingleton(SignatureScheduleBloc());
    GetIt.I.registerSingleton(ScheduleSelectedDayBloc());
    GetIt.I.registerSingleton(ScheduleBloc());
    GetIt.I.registerSingleton(NotesBloc());
    GetIt.I.registerSingleton(SearchNotesBloc());

    GetIt.I.registerSingleton(NotesModeCubit());
    GetIt.I.registerSingleton(CurrentTimeCubit());
    GetIt.I.registerSingleton(MapCubit());
    GetIt.I.registerSingleton(FloorMapCubit());
    GetIt.I.registerSingleton(SelectingScheduleChoosePageCubit());
  }
}