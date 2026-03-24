import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';

class LoadingProfileWidget extends StatelessWidget {
  const LoadingProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmer.circle(height: 123),
        20.hs(),
        Expanded(
          child: Column(
            children: [
              AppShimmer.container(height: 63),
              8.vs(),
              AppShimmer.container(height: 14),
              5.vs(),
              AppShimmer.container(height: 14),
              5.vs(),
              AppShimmer.container(height: 14),
            ],
          ),
        )
      ],
    );
  }
  
}