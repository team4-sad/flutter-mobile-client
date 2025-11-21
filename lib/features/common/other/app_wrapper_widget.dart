import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/features/switch-theme/theme_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

import 'di.dart';

class AppWrapperWidget extends StatelessWidget {

  final Widget Function(BuildContext context, AppThemeExtension extension) appBuilder;

  const AppWrapperWidget({super.key, required this.appBuilder});

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
          return BlocBuilder<LocaleBloc, LocaleState>(
            bloc: GetIt.I.get<LocaleBloc>(),
            builder: (context, state) {
              context.setLocale(state.locale);
              return ScreenUtilInit(
                  designSize: const Size(360, 750),
                  builder: (context, _) {
                    return appBuilder(context, appThemeExtension);
                  }
              );
            },
          );
        },
      ),
    );
  }

}