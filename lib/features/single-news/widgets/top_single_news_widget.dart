import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class TopSingleNewsWidget extends StatelessWidget {
  final String title;
  final String date;

  const TopSingleNewsWidget({
    super.key, 
    required this.title, 
    required this.date
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TS.light15.use(context.palette.text),
        ).p(25.horizontal()),
        4.vs(),
        IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 10,
                decoration: BoxDecoration(
                  color: context.palette.accent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
              ),
              Text(
                title,
                style: TS.medium20.use(context.palette.text),
              ).p(15.horizontal()).e(),
            ],
          ),
        ),
      ],
    );
  }
}
