import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
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

  final items = [
    NewsModel(
      id: "6604",
      title: "Студенты МИИГАиК на фестивале \"Открытый город\"",
      description: "Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"",
      date: "22.09.2025",
      imageLink: "https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg",
      newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
      id: "6604",
      title: "Студенты МИИГАиК на фестивале \"Открытый город\"",
      date: "22.09.2025",
      imageLink: "https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg",
      newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
      id: "6604",
      title: "Студенты МИИГАиК на фестивале \"Открытый город\"",
      description: "Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"",
      date: "22.09.2025",
      newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
      id: "6604",
      title: "Студенты МИИГАиК на фестивале \"Открытый город\"",
      date: "22.09.2025",
      newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
  ];

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
                    (index == 0)
                      ? NewsItemShimmerWidget()
                      : NewsItemWidget(newsModel: items[index-1]),
                  itemCount: items.length + 1,
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
              NoNewsPlaceholderWidget.noSearch().s(),
              18.svs(),
              NoNewsPlaceholderWidget.empty().s(),
              120.svs()
            ],
          ),
        ],
      ),
    );
  }
}