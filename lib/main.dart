import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/package_info_extension.dart';
import 'package:miigaik/features/common/other/di.dart';
import 'package:miigaik/features/root/root_page.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'features/switch-theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  DI.init();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale("ru")],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!GetIt.I.isRegistered<LocaleBloc>()) {
      GetIt.I.registerSingleton(
        LocaleBloc(context.supportedLocales, context.locale),
      );
    }

    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: GetIt.I.get<ThemeBloc>(),
      builder: (context, state) {
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
              home: Stack(
                children: [
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
                ],
              ),
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
    );
  }
}
