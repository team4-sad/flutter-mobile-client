import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsSearchField extends StatelessWidget {
  const NewsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: context.palette.container,
        filled: true,
        hintText: 'Поиск новостей',
        hintStyle: TS.regular15.use(context.palette.subText),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 14, right: 1),
          child: Icon(
            I.search,
            color: context.palette.subText,
            size: 22,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none
        ),
        constraints: BoxConstraints(),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

}