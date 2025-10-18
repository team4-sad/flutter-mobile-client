import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item_shimmer.dart';
import 'package:miigaik/theme/values.dart';

class LoadingNewsContent extends StatelessWidget {
  const LoadingNewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, __) => NewsItemShimmerWidget(),
      separatorBuilder: (_, __) => separateNews.vs(),
      itemCount: countShimmersLoadingNews
    );
  }
}