import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/common/widgets/tile_widget.dart';
import 'package:miigaik/features/switch-locale/locale_bloc.dart';
import 'package:miigaik/features/switch-theme/theme_bloc.dart';
import 'package:miigaik/theme/app_theme.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final localeBloc = GetIt.I.get<LocaleBloc>();
  final themeBloc = GetIt.I.get<ThemeBloc>();

  final languages = const {
    "ru": "Русский",
    "en": "English"
  };

  void selectLanguage(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.palette.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        child: Column(
          children: [
            Text("Язык", style: TS.medium20.use(context.palette.text)),
            20.vs(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 10),
                itemBuilder: (context, index){
                  final locale = context.supportedLocales[index];
                  return TileWidget(
                    value: languages[locale.languageCode] ?? locale.languageCode,
                    onTap: (){
                      localeBloc.add(ChangeLocaleEvent(newLocale: locale));
                      Navigator.pop(context);
                    },
                  );
                },
                separatorBuilder: (_, __) => 10.vs(),
                itemCount: context.supportedLocales.length,
              ),
            ),
          ],
        )
      );
    });
  }

  void selectTheme(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.palette.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
          ),
          child: Column(
            children: [
              Text("Тема", style: TS.medium20.use(context.palette.text)),
              20.vs(),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 10),
                  itemBuilder: (context, index){
                    final appTheme = AppTheme.values[index];
                    return TileWidget(
                      value: appTheme.name,
                      onTap: (){
                        themeBloc.add(ChangeAppThemeEvent(newAppTheme: appTheme));
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (_, __) => 10.vs(),
                  itemCount: AppTheme.values.length,
                ),
              ),
            ],
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Настройки"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TileWidget(
                value: languages[localeBloc.state.locale.languageCode] ?? "Unknown",
                title: "Язык / Language",
                onTap: () => selectLanguage(context),
              ),
              10.vs(),
              TileWidget(
                value: themeBloc.state.appTheme.name,
                title: "Выбор темы",
                onTap: () => selectTheme(context)
              ),
              10.vs(),
            ],
          ),
        ),
      ),
    );
  }

}