import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class NewsItemShimmerWidget extends StatelessWidget {
  const NewsItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      decoration: BoxDecoration(
        color: context.palette.container,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppShimmer.image(width: 1.sw),
          10.vs(),
          AppShimmer.bigText(width: 1.sw)
        ],
      ),
    );
  }
}