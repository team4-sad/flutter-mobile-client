import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/iterable_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class TextBlock extends StatelessWidget {

  final String title;
  final String? hint;
  final List<Widget> children;

  const TextBlock({
    super.key,
    required this.title,
    required this.children,
    this.hint
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TS.bold14.use(context.palette.accent)),
        if (hint != null)
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(hint!, style: TS.regular12.use(context.palette.subText)),
          ),
        10.vs(),
        ...children.sep(() => 10.vs())
      ],
    );
  }
}