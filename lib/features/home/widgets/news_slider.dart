import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/news/models/news_model.dart';
import 'package:miigaik/features/news/widgets/news_item.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/values.dart';

class NewsSlider extends StatefulWidget {

  final List<NewsModel> news;

  const NewsSlider({super.key, required this.news});

  @override
  State<NewsSlider> createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {

  final pageController = PageController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpandablePageView.builder(
            controller: pageController,
            onPageChanged: (newPage){
              setState(() {
                current = newPage;
              });
            },
            itemCount: widget.news.length,
            itemBuilder: (BuildContext context, int index) {
              final newsModel = widget.news[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPaddingPage
                ),
                child: SizedBox(
                  height: 216.h,
                  child: NewsItemWidget(
                    newsModel: newsModel,
                    showDescription: false,
                    maxLinesTitle: 2,
                  )
                ),
              );
            },
          ),
          8.vs(),
          _PageViewIndicator(
            count: widget.news.length,
            current: current,
          )
        ],
      ),
    );
  }
}

class _PageViewIndicator extends StatelessWidget {

  final int count;
  final int current;

  const _PageViewIndicator({
    required this.count,
    required this.current,
  });

  Widget buildDot(BuildContext context, bool isSelected) => CircleAvatar(
    radius: 2.5,
    backgroundColor: (isSelected)
      ? context.palette.subText
      : context.palette.container,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => buildDot(context, index == current)
      )
    );
  }
}