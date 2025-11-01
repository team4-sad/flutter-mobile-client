import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';

class LoadingAddScheduleContent extends StatelessWidget {
  const LoadingAddScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        spacing: 10,
        children: [
          AppShimmer(height: 60.h),
          AppShimmer(height: 60.h),
          AppShimmer(height: 60.h),
          AppShimmer(height: 60.h),
          AppShimmer(height: 60.h),
          AppShimmer(height: 60.h),
          AppShimmer(height: 60.h),
        ],
      ),
    );
  }
}
