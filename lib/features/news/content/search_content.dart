import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/bloc/initial_state.dart';
import 'package:miigaik/core/bloc/pagination_error_state.dart';
import 'package:miigaik/core/bloc/pagination_loading_state.dart';
import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/core/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/news/bloc/search_news_bloc/search_news_bloc.dart';
import 'package:miigaik/features/news/models/news_model.dart';
import 'package:miigaik/features/news/content/loading_news_content.dart';

import 'empty_news_content.dart';
import 'error_news_content.dart';
import 'list_news_content.dart';

class SearchContent extends StatelessWidget {
  SearchContent({super.key});

  final NewsSearchBloc searchBloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsSearchBloc, NewsSearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is WithDataState<NewsModel> &&
            (state as WithDataState<NewsModel>).hasNotEmptyData) {
          return ListNewsContent(
            state: state as WithDataState<NewsModel>,
            onTapRetry: _onTapRetry,
          );
        } else if (state is PaginationLoadingState) {
          return LoadingNewsContent();
        } else if (state is WithDataState<NewsModel> &&
            (state as WithDataState<NewsModel>).hasEmptyData) {
          return EmptyNewsContent();
        } else if (state is InitialState) {
          return SizedBox().s();
        } else {
          return ErrorNewsContent(
            exception: (state is PaginationErrorState)
                ? (state as PaginationErrorState).error
                : UnimplementedError(),
            onTapRetry: _onTapRetry,
          );
        }
      },
    );
  }

  void _onTapRetry() {
    searchBloc.add(RetrySearchEvent());
  }
}
