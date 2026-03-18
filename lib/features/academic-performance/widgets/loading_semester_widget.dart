import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';
import 'package:miigaik/theme/values.dart';

class LoadingSemestersWidget extends StatelessWidget {
  const LoadingSemestersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      child: ListView.separated(
        padding: EdgeInsetsGeometry.symmetric(horizontal: horizontalPaddingPage),
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => 10.hs(),
        itemBuilder: (context, index) => AppShimmer.container(height: 28, width: 90)
      ),
    );
  }
}