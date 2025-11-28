import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class TileWidget extends StatefulWidget {

  final String value;
  final String? title;
  final ImageProvider? image;
  final Widget? widget;
  final VoidCallback? onTap;

  const TileWidget({
    super.key,
    required this.value,
    this.title,
    this.image,
    this.widget,
    this.onTap
  });

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {

  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isOpened = !isOpened;
        });
        if (widget.onTap != null){
          widget.onTap!();
        }
      },
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.palette.container
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.title != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(widget.title!, style: TS.regular12.use(context.palette.subText)),
                        ),
                      Text(widget.value, style: TS.medium15.use(context.palette.text)),
                    ],
                  ),
                ),
                if (widget.image != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: CircleAvatar(
                      foregroundImage: widget.image,
                      radius: 20,
                    ),
                  )
              ],
            ),
            if (isOpened)
              ?widget.widget
          ],
        ),
      ),
    );
  }
}