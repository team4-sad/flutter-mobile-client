import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item_shimmer.dart';
import 'package:miigaik/features/root/tabs/news/widgets/no_news.dart';
import 'package:miigaik/theme/values.dart';

import 'news_header.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showDivider = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 0;
    if (isScrolled != _showDivider) {
      setState(() => _showDivider = isScrolled);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              PinnedHeaderSliver(
                child: NewsHeader(
                  showDivider: _showDivider,
                  contentPadding: EdgeInsets.only(
                    left: horizontalPaddingPage,
                    right: horizontalPaddingPage,
                    top: 59,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) =>
                    (index % 2 == 0)
                      ? NewsItemWidget()
                      : NewsItemShimmerWidget(),
                  itemCount: 5,
                  separatorBuilder: (_, __) => 20.vs(),
                ),
              ),
              SliverPadding(
                sliver: PlaceholderWidget.noConnection(
                  onButtonPress: (){

                  },
                ).s(),
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              SliverPadding(
                sliver: PlaceholderWidget.somethingWentWrong(
                  onButtonPress: (){

                  },
                ).s(),
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              NoNewsPlaceholderWidget().s(),
              120.svs()
            ],
          ),
        ],
      ),
    );
  }
}