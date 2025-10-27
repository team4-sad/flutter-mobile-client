import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AppShimmer extends StatelessWidget {

  final double? height;
  final double? width;

  const AppShimmer({
    super.key,
    this.width,
    this.height
  });

  AppShimmer.text({
    super.key,
    required this.width
  }): height = 20.h;

  AppShimmer.bigText({
    super.key,
    required this.width
  }): height = 36.h;

  AppShimmer.image({
    super.key,
    required this.width
  }): height = 135.h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Shimmer(
          interval: Duration(seconds: 0),
          duration: Duration(seconds: 2),
          color: context.palette.subText,
          direction: ShimmerDirection.fromLeftToRight(),
          child: Container(
            height: height,
            width: width,
            color: context.palette.background,
          ),
        )
      ),
    );
  }
}