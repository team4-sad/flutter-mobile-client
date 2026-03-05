import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/extensions/package_info_extension.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/core/widgets/tile_widget.dart';
import 'package:miigaik/features/about-app/link_row.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "О приложении"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TileWidget(
                value: "Open Source",
                title: "Тип приложения",
                onTap: (){
                  launchUrl(Uri.parse("https://github.com/team4-sad/flutter-mobile-client"));
                },
              ),
              10.vs(),
              TileWidget(value: GetIt.I.get<PackageInfo>().fullVersion, title: "Версия приложения"),
              10.vs(),
              TileWidget(
                value: "Наша группа в ТГ",
                title: "Сообщить об ошибке",
                onTap: (){
                  launchUrl(Uri.parse("https://t.me/+XYkGJFYILntjNGIy"));
                },
              ),
              30.vs(),
              Text("Команда разработки", style: TS.medium20.use(context.palette.text)),
              10.vs(),
              TileWidget(
                value: "Струков Артемий",
                title: "Мобильный разработчик и Team Lead",
                image: AssetImage("assets/team/1.png"),
                widget: LinkRow(
                  icon: Icon(I.github, color: context.palette.text),
                  link: "https://github.com/Calrission"
                ),
              ),
              10.vs(),
              TileWidget(
                value: "Золотарева Светлана",
                title: "UI/UX дизайнер",
                image: AssetImage("assets/team/2.png"),
                widget: LinkRow(
                  link: "🩷",
                  isCanOpenLink: false,
                ),
              ),
              10.vs(),
              TileWidget(
                value: "Корязов Дмитрий",
                title: "Бэкенд разработчик",
                image: AssetImage("assets/team/3.png"),
                widget: LinkRow(
                  icon: Icon(I.github, color: context.palette.text),
                  link: "https://github.com/Schr0dinger0"
                ),
              ),
              20.vs(),
            ],
          ),
        ),
      ),
    );
  }

}