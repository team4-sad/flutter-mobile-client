import 'package:flutter/material.dart';
import 'package:miigaik/features/common/bloc/with_data_state.dart';
import 'package:miigaik/features/common/bloc/with_pagination_state.dart';
import 'package:miigaik/features/common/extensions/iterable_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_list_bloc/news_list_bloc.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item_shimmer.dart';
import 'package:miigaik/features/single-news/single_news_page.dart';
import 'package:miigaik/theme/values.dart';

class ListNewsContent extends StatelessWidget {

  final WithDataState<NewsModel> _state;
  final VoidCallback _onTapRetry;

  const ListNewsContent({
    super.key,
    required WithDataState<NewsModel> state,
    required void Function() onTapRetry
  }) : _onTapRetry = onTapRetry, _state = state;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        if (_state.data != null)
          if (_state.data!.isNotEmpty)
            ..._state.data!.mapSep(
              (e) => NewsItemWidget(
                newsModel: e,
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SingleNewsPage(
                      newsId: e.id
                    ))
                  );
                },
              ),
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