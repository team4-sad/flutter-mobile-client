import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class TagWidget extends StatefulWidget {
  final String title;
  final String? fullTitle;
  final bool isSelected;
  final VoidCallback? onTap;

  const TagWidget({
    super.key, 
    required this.title, 
    this.fullTitle,
    this.isSelected = true,
    this.onTap
  });

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {

  bool isOpened = false;
  String get display => (isOpened && widget.fullTitle != null)
    ? widget.fullTitle!
    : widget.title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (widget.fullTitle != null) {
          setState(() {
            isOpened = !isOpened;
          });
        }
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (widget.isSelected)
              ? context.palette.calendar
              : context.palette.container,
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        child: Text(
          display,
          style: TS.regular14.use(
            (widget.isSelected) ? context.palette.unAccent : context.palette.text,
          ),
        ),
      ),
    );
  }
}
