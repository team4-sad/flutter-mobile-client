import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class SearchFieldWidget extends StatefulWidget {
  final String? _hint;
  final void Function(bool)? _onChangeFocusSearchField;
  final void Function(String)? _onChangeText;
  final void Function(String)? _onConfirm;
  final TextEditingController _textEditingController;
  final bool _enableClear;
  final VoidCallback? _onTapClear;

  SearchFieldWidget({
    super.key,
    TextEditingController? textEditingController,
    void Function(bool)? onChangeFocusSearchField,
    void Function(String)? onChangeText,
    void Function(String)? onConfirm,
    bool enableClear = true,
    String? hint,
    void Function()? onTapClear,
  }) : _onTapClear = onTapClear,
       _enableClear = enableClear,
       _textEditingController =
           textEditingController ?? TextEditingController(),
       _onChangeFocusSearchField = onChangeFocusSearchField,
       _onChangeText = onChangeText,
       _onConfirm = onConfirm,
       _hint = hint;

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget._onChangeFocusSearchField,
      child: TextField(
        controller: widget._textEditingController,
        onTapOutside: (_) {
          _focusNode.unfocus();
        },
        onChanged: (text) {
          setState(() {
            if (widget._onChangeText != null) {
              widget._onChangeText!(text);
            }
          });
        },
        onSubmitted: widget._onConfirm,
        focusNode: _focusNode,
        style: TS.regular15.use(context.palette.text),
        decoration: InputDecoration(
          fillColor: context.palette.container,
          filled: true,
          hintText: widget._hint,
          hintStyle: TS.regular15.use(context.palette.subText),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 1),
            child: Icon(I.search, color: context.palette.subText, size: 22),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon:
              (widget._enableClear &&
                  widget._textEditingController.text.isNotEmpty)
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget._textEditingController.clear();
                      if (widget._onTapClear != null) {
                        widget._onTapClear!();
                      }
                    });
                  },
                  child: Icon(
                    I.close,
                    size: 18,
                    color: context.palette.subText,
                  ),
                )
              : SizedBox.shrink(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          constraints: BoxConstraints(),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
