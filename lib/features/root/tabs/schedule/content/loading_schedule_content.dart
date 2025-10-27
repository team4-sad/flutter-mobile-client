import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';

class LoadingScheduleContent extends StatelessWidget {
  const LoadingScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(children: [
      AppShimmer.container(height: 152),
      15.vs(),
      AppShimmer.container(height: 40),
      15.vs(),
      AppShimmer.container(height: 152),
      15.vs(),
      AppShimmer.container(height: 40),
      15.vs(),
      AppShimmer.container(height: 152),
      15.vs(),
      AppShimmer.container(height: 40),
      15.vs(),
      AppShimmer.container(height: 152),
      90.vs(),
    ], );
  }
}
