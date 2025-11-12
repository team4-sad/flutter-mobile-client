import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemProfileWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ItemProfileWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Ink(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.palette.container,
        ),
        child: Row(
          children: [
            Expanded(child: Text(title, style: TS.regular15.use(context.palette.text))),
            Icon(Icons.arrow_right_outlined, size: 32, color: context.palette.text,)
          ],
        ),
      ),
    );
  }
}
