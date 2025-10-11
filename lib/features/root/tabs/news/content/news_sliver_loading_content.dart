import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item_shimmer.dart';
import 'package:miigaik/theme/values.dart';

class NewsSliverLoadingContent extends StatelessWidget {
  const NewsSliverLoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: heightAreaBottomNavBar.bottom(),
      sliver: SliverList.separated(
        itemBuilder: (_, __) => NewsItemShimmerWidget(),
        separatorBuilder: (_, __) => separateNews.vs(),
        itemCount: countShimmersLoadingNews
      ),
    );
  }
}