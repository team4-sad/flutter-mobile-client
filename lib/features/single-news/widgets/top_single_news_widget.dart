import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class TopSingleNewsWidget extends StatelessWidget {

  final String title;

  const TopSingleNewsWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "01.10.2025", style: TS.light15.use(context.palette.text)
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
                      topRight: Radius.circular(5.r),
                      bottomRight: Radius.circular(5.r),
                    )
                ),
              ),
              Text(title, style: TS.medium20.use(context.palette.text)
              ).p(15.horizontal()).e(),
            ],
          ),
        ),
      ],
    );
  }

}