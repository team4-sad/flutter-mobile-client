import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/network-connection/exception/no_network_exception.dart';
import 'package:miigaik/generated/types.dart';
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

  PlaceholderWidget.noConnection({
    key,
    VoidCallback? onButtonPress,
  }): this(
    key: key,
    title: S.no_connection.tr(),
    subTitle: S.check_connection.tr(),
    textButton: S.retry.tr(),
    onButtonPress: onButtonPress
  );

  PlaceholderWidget.somethingWentWrong({
    key,
    VoidCallback? onButtonPress,
  }): this(
      key: key,
      title: S.something_went_wrong.tr(),
      subTitle: S.try_again.tr(),
      textButton: S.retry.tr(),
      onButtonPress: onButtonPress
  );

  PlaceholderWidget.emptyNews({
    key,
  }): this(
      key: key,
      title: S.no_news.tr(),
      subTitle: S.no_news_sub.tr(),
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
          Padding(
            padding: 8.top(),
            child: Text(
              subTitle!, style: TS.regular15.use(context.palette.subText),
              textAlign: TextAlign.center
            ),
          ),
        if (title != null || subTitle != null)
          15.vs(),
        if (onButtonPress != null || textButton != null)
          FilledButton(
            onPressed: onButtonPress,
            child: Text(
              textButton ?? S.retry,
              style: TS.medium15,
            )
          )
      ],
    );
  }
}