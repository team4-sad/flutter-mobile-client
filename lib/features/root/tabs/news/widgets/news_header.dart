import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_search_field.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsHeader extends StatelessWidget {

  final bool _showDivider;
  final EdgeInsets _contentPadding;

  const NewsHeader({
    super.key,
    required bool showDivider,
    required EdgeInsets contentPadding,
  }):
    _showDivider = showDivider,
    _contentPadding = contentPadding;

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
                Text('Новости', style: TS.medium25.use(context.palette.text)),
                10.vs(),
                NewsSearchField()
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