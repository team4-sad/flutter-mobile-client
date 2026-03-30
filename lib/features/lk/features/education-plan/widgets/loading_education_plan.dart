import 'package:flutter/material.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';
import 'package:miigaik/theme/values.dart';

class LoadingEducationPlan extends StatelessWidget {
  const LoadingEducationPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
          child: Column(
            spacing: 10,
            children: [
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
              AppShimmer.container(height: 134),
            ],
          ),
        ),
      ),
    );
  }
  
}