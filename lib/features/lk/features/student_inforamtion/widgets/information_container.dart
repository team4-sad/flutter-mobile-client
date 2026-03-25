import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class InformationContainer extends StatelessWidget {
  final double width;
  final String title;
  final String value;

  const InformationContainer({
    super.key,
    double? width,
    required this.title,
    required this.value
  }): width = width ?? double.infinity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsetsGeometry.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.palette.container
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TS.regular12.use(context.palette.subText)),
          3.vs(),
          Text(value, style: TS.medium14.use(context.palette.text))
        ],
      ),
    );
  }
}