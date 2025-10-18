import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsSearchField extends StatelessWidget {
  final void Function(bool) _onChangeFocusSearchField;
  final void Function(String) _onChangeText;
  final _focusNode = FocusNode();

  NewsSearchField({
    super.key,
    required void Function(bool) onChangeFocusSearchField,
    required void Function(String) onChangeText
  }):
    _onChangeFocusSearchField = onChangeFocusSearchField,
    _onChangeText = onChangeText;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _onChangeFocusSearchField,
      child: TextField(
        onTapOutside: (_){
          _focusNode.unfocus();
        },
        onChanged: _onChangeText,
        focusNode: _focusNode,
        style: TS.regular15.use(context.palette.text),
        decoration: InputDecoration(
          fillColor: context.palette.container,
          filled: true,
          hintText: S.news_search.tr(),
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
      ),
    );
  }

}