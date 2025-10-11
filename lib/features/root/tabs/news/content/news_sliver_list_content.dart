import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/iterable_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_list_bloc/news_list_bloc.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item_shimmer.dart';
import 'package:miigaik/theme/values.dart';

class NewsSliverListContent extends StatelessWidget {

  final WithDataNewsListState _state;
  final VoidCallback _onTapRetry;

  const NewsSliverListContent({
    super.key,
    required WithDataNewsListState state,
    required void Function() onTapRetry
  }) : _onTapRetry = onTapRetry, _state = state;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        if (_state.news != null)
          if (_state.news!.isNotEmpty)
            ..._state.news!.mapSep(
              (e) => NewsItemWidget(newsModel: e),
              () => separateNews.vs()
            ),
        if (_state is NewsListError)
          Padding(
            padding: separateNews.top(),
            child: PlaceholderWidget.fromException(
              _state.error, _onTapRetry
            ),
          ),
        if (_state is NewsListLoading)
          Padding(
            padding: separateNews.top(),
            child: NewsItemShimmerWidget(),
          ),
        heightAreaBottomNavBar.vs()
      ]
    );
  }

}