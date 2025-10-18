import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_search_field.dart';
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsHeader extends StatelessWidget {

  final bool _showDivider;
  final EdgeInsets _contentPadding;
  final void Function(bool) _onChangeFocusSearchField;
  final void Function(String) _onChangeText;

  const NewsHeader({
    super.key,
    required bool showDivider,
    required EdgeInsets contentPadding,
    required void Function(bool) onChangeFocusSearchField,
    required void Function(String) onChangeText
  }):
    _showDivider = showDivider,
    _onChangeFocusSearchField = onChangeFocusSearchField,
    _contentPadding = contentPadding,
    _onChangeText = onChangeText;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.palette.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: _contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.news_title.tr(), style: TS.medium25.use(context.palette.text)),
                10.vs(),
                NewsSearchField(
                  onChangeFocusSearchField: _onChangeFocusSearchField,
                  onChangeText: _onChangeText,
                )
              ],
            ),
          ),
          14.vs(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 1,
            color: _showDivider
                ? context.palette.container
                : context.palette.container.withAlpha(0),
          ),
        ],
      ),
    );
  }

}