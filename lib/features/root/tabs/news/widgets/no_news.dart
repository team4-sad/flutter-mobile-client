import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NoNewsPlaceholderWidget extends StatelessWidget {

  final String title;
  final String subTitle;

  const NoNewsPlaceholderWidget({
    super.key,
    required this.title,
    required this.subTitle
  });

  const NoNewsPlaceholderWidget.noSearch({key}): this(
    key: key,
    title: "Новостей нет",
    subTitle: "Поменяйте запрос\nи попробуйте ещё раз"
  );

  const NoNewsPlaceholderWidget.empty({key}): this(
    key: key,
    title: "Новостей нет",
    subTitle: "Следите за обновлениями\nвместе с приложением МИИГАиК :)"
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TS.medium20,
          textAlign: TextAlign.center
        ),
        8.vs(),
        Text(
          subTitle,
          style: TS.regular15.use(context.palette.subText),
          textAlign: TextAlign.center
        ),
      ],
    );
  }

}