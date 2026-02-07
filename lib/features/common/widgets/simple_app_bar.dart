import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/iterable_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBackPress;
  final List<Widget> action;

  const SimpleAppBar({
    super.key, 
    this.title,
    this.onBackPress,
    this.action = const []
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPaddingPage,
        right: horizontalPaddingPage,
        top: 59,
        bottom: 12,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBackPress ?? () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsetsGeometry.all(8),
              child: Icon(I.back, color: context.palette.text)
            ),
          ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title!,
                style: TS.medium20.use(context.palette.text),
              ),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: action.sep(() => 10.hs()).toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 59);
}
