import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class TagWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const TagWidget({
    super.key, 
    required this.title, 
    this.isSelected = true,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (isSelected)
              ? context.palette.calendar
              : context.palette.container,
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        child: Text(
          title,
          style: TS.regular14.use(
            (isSelected) ? context.palette.unAccent : context.palette.text,
          ),
        ),
      ),
    );
  }
}
