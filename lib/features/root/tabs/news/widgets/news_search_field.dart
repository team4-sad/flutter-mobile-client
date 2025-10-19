import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsSearchField extends StatefulWidget {
  final void Function(bool) _onChangeFocusSearchField;
  final void Function(String) _onChangeText;
  final TextEditingController _textEditingController;
  final bool _showClear;
  final VoidCallback? _onTapClear;

  const NewsSearchField({
    super.key,
    required TextEditingController textEditingController,
    required void Function(bool) onChangeFocusSearchField,
    required void Function(String) onChangeText,
    required bool showClear,
    required void Function()? onTapClear
  }): _onTapClear = onTapClear, _showClear = showClear, _textEditingController = textEditingController,
    _onChangeFocusSearchField = onChangeFocusSearchField,
    _onChangeText = onChangeText;

  @override
  State<NewsSearchField> createState() => _NewsSearchFieldState();
}

class _NewsSearchFieldState extends State<NewsSearchField> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget._onChangeFocusSearchField,
      child: TextField(
        controller: widget._textEditingController,
        onTapOutside: (_){
          _focusNode.unfocus();
        },
        onChanged: (text){
          setState(() {
            widget._onChangeText(text);
          });
        },
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
          suffixIcon: (
              widget._showClear && widget._textEditingController.text.isNotEmpty
          ) ? GestureDetector(
            onTap: widget._onTapClear,
            child: Icon(
              I.close,
              size: 18,
              color: context.palette.subText
            )
          ) : SizedBox.shrink(),
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