import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;

  const SimpleAppBar({
    super.key, 
    required this.title, 
    this.onBackPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPaddingPage,
        right: horizontalPaddingPage,
        top: 59,
        bottom: 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBackPress ?? () {
              Navigator.pop(context);
            },
            child: Icon(I.back, color: context.palette.text),
          ),
          10.hs(),
          Text(
            title,
            style: TS.medium20.use(context.palette.text),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 59);
}
