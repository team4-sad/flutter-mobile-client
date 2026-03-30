import 'package:flutter/material.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';
import 'package:miigaik/theme/values.dart';

class LoadingPerformanceListWidget extends StatelessWidget {
  const LoadingPerformanceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: horizontalPaddingPage,
            right: horizontalPaddingPage,
            bottom: 60
          ),
          child: Column(
            spacing: 10,
            children: [
              AppShimmer.container(height: 152),
              AppShimmer.container(height: 152),
              AppShimmer.container(height: 152),
              AppShimmer.container(height: 152),
              AppShimmer.container(height: 152),
            ],
          ),
        ),
      ),
    );
  }
}