import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_search_field.dart';
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsHeader extends StatelessWidget {
  final bool showDivider;
  final EdgeInsets contentPadding;
  final void Function(bool) onChangeFocusSearchField;
  final void Function(String) onChangeText;
  final bool showTitle;

  const NewsHeader({
    super.key,
    required this.showDivider,
    required this.contentPadding,
    required this.onChangeFocusSearchField,
    required this.onChangeText,
    required this.showTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.palette.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: -1.0,
                        child: child,
                      ),
                    );
                  },
                  child: showTitle ? Text(
                    S.news_title.tr(),
                    key: const ValueKey('title'),
                    style: TS.medium25.use(context.palette.text),
                  ).p(10.bottom())
                    : const SizedBox.shrink(key: ValueKey('empty')),
                ),
                NewsSearchField(
                  onChangeFocusSearchField: onChangeFocusSearchField,
                  onChangeText: onChangeText,
                ),
              ],
            ),
          ),
          14.vs(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 1,
            color: showDivider
                ? context.palette.container
                : context.palette.container.withAlpha(0),
          ),
        ],
      ),
    );
  }
}