import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/iterable_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/network-connection/bloc/network_connection_bloc.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item.dart';
import 'package:miigaik/features/root/tabs/news/widgets/news_item_shimmer.dart';
import 'package:miigaik/theme/values.dart';

import 'bloc/news_list_bloc/news_list_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    newsBloc.add(FetchNewsListEvent());
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
          ),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: horizontalPaddingPage.w.horizontal(),
                  sliver: BlocBuilder<NewsListBloc, NewsListState>(
                    bloc: newsBloc,
                    builder: (context, state) {
                      if (state is WithDataNewsListState && state.hasNews) {
                        return SliverList.list(
                          children: [
                            if (state.news != null)
                              ...state.news!.mapSep(
                                (e) => NewsItemWidget(newsModel: e),
                                () => separateNews.vs()
                              ),
                            if (state is NewsListError)
                              Padding(
                                padding: separateNews.top(),
                                child: PlaceholderWidget.fromException(
                                  state.error, _onTapRetry
                                ),
                              ),
                            if (state is NewsListLoading)
                              Padding(
                                padding: separateNews.top(),
                                child: NewsItemShimmerWidget(),
                              ),
                            heightAreaBottomNavBar.vs()
                          ]
                        );
                      }else if (state is NewsListLoading){
                        return SliverPadding(
                          padding: heightAreaBottomNavBar.bottom(),
                          sliver: SliverList.separated(
                            itemBuilder: (_, __) => NewsItemShimmerWidget(),
                            separatorBuilder: (_, __) => separateNews.vs(),
                            itemCount: countShimmersLoadingNews
                          ),
                        );
                      } else {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: heightAreaBottomNavBar
                            ),
                            child: Center(
                              child: PlaceholderWidget.fromException(
                                (state is NewsListError)
                                  ? state.error
                                  : UnimplementedError(),
                                _onTapRetry,
                              )
                            ),
                          )
                        );
                      }
                    },
                  )
                ),
              ],
            ),
          ),
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

  void _onTapRetry(){
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