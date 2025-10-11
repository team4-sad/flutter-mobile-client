import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/root_page.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_list_bloc/news_list_bloc.dart';
import 'package:miigaik/features/root/tabs/news/repository/news_repository.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/theme/app_theme.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'features/common/other/http_override.dart';
import 'features/root/features/bottom-nav-bar/bloc/bottom_nav_bar_bloc.dart';
import 'features/root/features/bottom-nav-bar/items_nav_bar.dart';
import 'features/switch-theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  BadCertificateHttpOverrides.setup();

  GetIt.I.registerSingleton(ThemeBloc(AppTheme.defaultTheme()));
  GetIt.I.registerSingleton(BottomNavBarBloc(ItemNavBar.defaultItem()));

  final INewsRepository newsRepository = NewsRepository();
  GetIt.I.registerSingleton(NewsListBloc(newsRepository));

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
              theme: appThemeExtension.getThemeData(
                fontFamily: "Roboto"
              ),
              home: child
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