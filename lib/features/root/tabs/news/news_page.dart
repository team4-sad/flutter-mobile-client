import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/initial_state.dart';
import 'package:miigaik/features/common/bloc/pagination_error_state.dart';
import 'package:miigaik/features/common/bloc/pagination_loading_state.dart';
import 'package:miigaik/features/common/bloc/with_data_state.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/root/tabs/news/bloc/search_news_bloc/search_news_bloc.dart';
import 'package:miigaik/features/root/tabs/news/content/empty_news_content.dart';
import 'package:miigaik/features/root/tabs/news/content/error_news_content.dart';
import 'package:miigaik/features/root/tabs/news/content/list_news_content.dart';
import 'package:miigaik/features/root/tabs/news/content/loading_news_content.dart';
import 'package:miigaik/features/root/tabs/news/enum/news_page_mode.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/theme/values.dart';

import 'bloc/news_list_bloc/news_list_bloc.dart';
import 'bloc/news_page_mode_bloc/news_page_mode_bloc.dart';
import 'widgets/news_header.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showDivider = false;

  final NewsListBloc newsBloc = GetIt.I.get();
  final NewsSearchBloc searchBloc = GetIt.I.get();
  final NewsPageModeBloc modeBloc = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    newsBloc.add(FetchNewsListEvent());
  }

  Widget _builder(BuildContext context, state){
    if (state is WithDataState<NewsModel> && state.hasNotEmptyData) {
      return ListNewsContent(
        state: state,
        onTapRetry: _onTapRetry,
        controller: _scrollController,
      );
    } else if (state is PaginationLoadingState) {
      return LoadingNewsContent();
    } else if (state is WithDataState<NewsModel> && state.hasEmptyData) {
      return EmptyNewsContent();
    } else if (state is InitialState) {
      return SizedBox();
    } else {
      return ErrorNewsContent(exception: (state is PaginationErrorState)
          ? state.error
          : UnimplementedError(),
        onTapRetry: _onTapRetry
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NewsHeader(
            showDivider: _showDivider,
            contentPadding: EdgeInsets.only(
              left: horizontalPaddingPage,
              right: horizontalPaddingPage,
              top: paddingTopPage,
            ),
            onChangeFocusSearchField: (isFocus){
              final newMode = (isFocus) ? NewsPageMode.search : NewsPageMode.list;
              modeBloc.add(ChangeMode(newMode: newMode));
            },
          ),
          BlocBuilder<NewsPageModeBloc, NewsPageModeState>(
            bloc: modeBloc,
            builder: (context, state) {
              switch(state.currentMode){
                case NewsPageMode.list:
                  return BlocBuilder<NewsListBloc, NewsListState>(
                    bloc: newsBloc,
                    builder: _builder
                  );
                case NewsPageMode.search:
                  return BlocBuilder<NewsSearchBloc, NewsSearchState>(
                    bloc: searchBloc,
                    builder: _builder
                  );
              }
            },
          ).p(horizontalPaddingPage.w.horizontal()).e(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTapRetry() {
    newsBloc.add(RetryFetchNewsListEvent());
  }

  void _onScroll() {
    if (_isScrolled != _showDivider) {
      setState(() => _showDivider = _isScrolled);
    }
    if (_isBottom) {
      newsBloc.add(FetchNewsListEvent());
    }
  }

  bool get _isScrolled => _scrollController.offset > 0;

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    // срабатывает чуть раньше конца
    return current >= (maxScroll * 0.95);
  }
}