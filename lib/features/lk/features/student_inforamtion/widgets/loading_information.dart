import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';

class LoadingInformation extends StatelessWidget {
  const LoadingInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        children: [
          AppShimmer.text(width: 141),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
          20.vs(),
          AppShimmer.text(width: 141),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
          AppShimmer.container(height: 88),
        ],
      ),
    );
  }
  
}