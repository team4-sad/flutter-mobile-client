import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';

class LoadingSingleNewsContent extends StatelessWidget {
  const LoadingSingleNewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer.text(width: 110.w),
          4.vs(),
          AppShimmer.text(width: 1.sw),
          20.vs(),
          AppShimmer.image(width: 1.sw),
          20.vs(),
          AppShimmer.text(width: 1.sw),
          5.vs(),
          AppShimmer.text(width: 1.sw),
          5.vs(),
          AppShimmer.text(width: 1.sw),
          5.vs(),
          AppShimmer.text(width: 1.sw),
          5.vs(),
          AppShimmer.text(width: 0.5.sw),
          20.vs(),
          AppShimmer.image(width: 1.sw),
          100.vs(),
        ],
      ),
    ).p(25.horizontal());
  }
}