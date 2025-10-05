import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/common/features/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/features/switch-theme/theme_bloc.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: Column(
          spacing: 14,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(I.schedule),
                Icon(I.map),
                Icon(I.news),
                Icon(I.profile),
                Icon(I.notes),
                Icon(I.search),
                Icon(I.back),
                Icon(I.close),
              ],
            ),
            Text(
              context.tr(T.test),
              style: TS.medium25.use(context.palette.subText),
            ),
            FilledButton(
              onPressed: (){
                GetIt.I.get<LocaleBloc>().add(NextLocaleEvent());
              },
              child: Text(
                context.tr(T.change_locale),
                  style: TextStyle(
                    color: context.palette.unAccent
                  ),
              ),
            ),
            FilledButton(onPressed: (){
              GetIt.I.get<ThemeBloc>().add(NextAppThemeEvent());
            }, child: Text(context.tr(T.change_theme)))
          ],
        )
      ),
    );
  }
}