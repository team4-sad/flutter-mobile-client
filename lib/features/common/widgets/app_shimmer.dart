import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AppShimmer extends StatelessWidget {

  final double? height;
  final double? width;
  final double? borderRadius;

  const AppShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius
  });

  AppShimmer.text({
    super.key,
    required this.width
  }): height = 20.h, borderRadius=10;

  AppShimmer.bigText({
    super.key,
    required this.width
  }): height = 36.h, borderRadius=10;

  AppShimmer.image({
    super.key,
    required this.width
  }): height = 135.h, borderRadius=10;

  const AppShimmer.container({
    super.key,
    required this.height
  }): width = double.infinity, borderRadius=10;

  const AppShimmer.circle({
    super.key,
    required this.height
  }): width = height, borderRadius = height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
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