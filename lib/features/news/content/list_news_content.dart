import 'package:flutter/material.dart';
import 'package:miigaik/core/bloc/pagination_loading_state.dart';
import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/features/news/models/news_model.dart';
import 'package:miigaik/features/news/widgets/news_item.dart';
import 'package:miigaik/features/news/widgets/news_item_shimmer.dart';
import 'package:miigaik/features/single-news/single_news_page.dart';
import 'package:miigaik/theme/values.dart';

import '../../../core/extensions/iterable_extensions.dart';

class ListNewsContent extends StatelessWidget {

  final WithDataState<NewsModel> _state;
  final VoidCallback _onTapRetry;

  const ListNewsContent({
    super.key,
    required WithDataState<NewsModel> state,
    required VoidCallback onTapRetry,
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
        if (_state is WithErrorState)
          Padding(
            padding: separateNews.top(),
            child: PlaceholderWidget.fromException(
              (_state as WithErrorState).error,
              _onTapRetry
            ),
          ),
        if (_state is PaginationLoadingState)
          Padding(
            padding: separateNews.top(),
            child: NewsItemShimmerWidget(),
          ),
        heightAreaBottomNavBar.vs()
      ]
    );
  }
}