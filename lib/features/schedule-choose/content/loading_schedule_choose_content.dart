import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';

class LoadingScheduleChooseContent extends StatelessWidget {
  const LoadingScheduleChooseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, __) => AppShimmer(width: 1.sp, height: 60),
      separatorBuilder: (_, __) => 20.vs(),
      itemCount: 5
    );
  }
  
}