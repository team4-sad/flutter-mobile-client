import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/network-connection/exception/no_network_exception.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class PlaceholderWidget extends StatelessWidget {

  final String? textButton;
  final String? title;
  final String? subTitle;
  final VoidCallback? onButtonPress;

  const PlaceholderWidget({
    super.key,
    this.title,
    this.subTitle,
    this.textButton,
    this.onButtonPress
  });

  const PlaceholderWidget.noConnection({
    key,
    VoidCallback? onButtonPress,
  }): this(
    key: key,
    title: "Нет соединения",
    subTitle: "Проверьте соединение с\nсетью и попробуйте ещё раз",
    textButton: "Повторить попытку",
    onButtonPress: onButtonPress
  );

  const PlaceholderWidget.somethingWentWrong({
    key,
    VoidCallback? onButtonPress,
  }): this(
      key: key,
      title: "Что-то пошло не так",
      subTitle: "Попробуйте ещё раз",
      textButton: "Повторить попытку",
      onButtonPress: onButtonPress
  );

  factory PlaceholderWidget.fromException(
    Object obj,
    VoidCallback? onButtonPress,
  ){
    switch(obj.runtimeType){
      case const (NoNetworkException):
        return PlaceholderWidget.noConnection(onButtonPress: onButtonPress);
      default:
        return PlaceholderWidget.somethingWentWrong(onButtonPress: onButtonPress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Text(title!, style: TS.medium20, textAlign: TextAlign.center),
        if (subTitle != null)
          Text(
            subTitle!, style: TS.regular15.use(context.palette.subText),
            textAlign: TextAlign.center
          ),
        if (title != null || subTitle != null)
          15.vs(),
        if (onButtonPress != null || textButton != null)
          FilledButton(
            onPressed: onButtonPress,
            child: Text(
              textButton ?? "Повторить попытку",
              style: TS.medium15,
            )
          )
      ],
    );
  }
}