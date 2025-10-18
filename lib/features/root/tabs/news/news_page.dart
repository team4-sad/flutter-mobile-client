import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/scroll_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/common/widgets/on_bottom_scroll_widget.dart';
import 'package:miigaik/features/root/tabs/news/bloc/search_news_bloc/search_news_bloc.dart';
import 'package:miigaik/features/root/tabs/news/content/list_content.dart';
import 'package:miigaik/features/root/tabs/news/content/search_content.dart';
import 'package:miigaik/features/root/tabs/news/enum/news_page_mode.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsPageModeBloc, NewsPageModeState>(
        bloc: modeBloc,
        builder: (context, state) {
          return Column(
            children: [
              NewsHeader(
                showDivider: _showDivider,
                contentPadding: EdgeInsets.only(
                  left: horizontalPaddingPage,
                  right: horizontalPaddingPage,
                  top: paddingTopPage,
                ),
                showTitle: state.currentMode == NewsPageMode.list,
                showBack: state.currentMode == NewsPageMode.search,
                onChangeText: (searchText) {
                  searchBloc.add(TypingEvent(searchText: searchText));
                },
                onBackTap: (){
                  modeBloc.add(ChangeMode(newMode: NewsPageMode.list));
                },
                onChangeFocusSearchField: (isFocus) {
                  if (searchBloc.state is NewsSearchInitial) {
                    final newMode = (isFocus)
                        ? NewsPageMode.search
                        : NewsPageMode.list;
                    modeBloc.add(ChangeMode(newMode: newMode));
                  }
                },
              ),
              Expanded(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    switch (state.currentMode) {
                      NewsPageMode.list => OnBottomScrollWidget(
                        controller: _scrollController,
                        onBottom: () {
                          newsBloc.add(FetchNewsListEvent());
                        },
                        child: ListContent(),
                      ),
                      NewsPageMode.search => OnBottomScrollWidget(
                        controller: _scrollController,
                        onBottom: () {
                          searchBloc.add(NextPageSearchEvent());
                        },
                        child: SearchContent(),
                      )
                    }
                  ],
                ).p(horizontalPaddingPage.w.horizontal()),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrolled != _showDivider) {
      setState(() => _showDivider = _isScrolled);
    }
  }

  bool get _isScrolled => _scrollController.offset > 0;
}