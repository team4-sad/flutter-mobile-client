import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';

class LoadingOrdersWidget extends StatelessWidget {
  const LoadingOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => AppShimmer.container(height: 165),
      separatorBuilder: (_, __) => 20.vs(),
      itemCount: 5,
    );
  }
}