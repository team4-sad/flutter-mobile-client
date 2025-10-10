import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NoNewsPlaceholderWidget extends StatelessWidget {
  const NoNewsPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            "Новостей нет",
            style: TS.medium20,
            textAlign: TextAlign.center
        ),
        8.vs(),
        Text(
            "Поменяйте запрос\nи попробуйте ещё раз",
            style: TS.regular15.use(context.palette.subText),
            textAlign: TextAlign.center
        ),
      ],
    );
  }

}