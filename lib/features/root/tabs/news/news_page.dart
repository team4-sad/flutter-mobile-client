import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
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
  final _scrollController = ScrollController();
  final _textEditingController = TextEditingController();
  bool _showDivider = false;

  final NewsListBloc _newsBloc = GetIt.I.get();
  final NewsSearchBloc _searchBloc = GetIt.I.get();
  final NewsPageModeBloc _modeBloc = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _newsBloc.add(FetchNewsListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsPageModeBloc, NewsPageModeState>(
        bloc: _modeBloc,
        builder: (context, state) {
          return Column(
            children: [
              NewsHeader(
                textController: _textEditingController,
                showDivider: _showDivider,
                contentPadding: EdgeInsets.only(
                  left: horizontalPaddingPage,
                  right: horizontalPaddingPage,
                  top: paddingTopPage,
                ),
                showTitle: state.currentMode == NewsPageMode.list,
                showBack: state.currentMode == NewsPageMode.search,
                showClear: state.currentMode == NewsPageMode.search,
                onChangeText: (searchText) {
                  _searchBloc.add(TypingEvent(searchText: searchText));
                },
                onClearTap: (){
                  _textEditingController.clear();
                  _searchBloc.add(DropSearchResult());
                },
                onBackTap: (){
                  _textEditingController.clear();
                  _searchBloc.add(DropSearchResult());
                  _modeBloc.add(ChangeMode(newMode: NewsPageMode.list));
                },
                onChangeFocusSearchField: (isFocus) {
                  if (_searchBloc.state is NewsSearchInitial) {
                    final newMode = (isFocus)
                        ? NewsPageMode.search
                        : NewsPageMode.list;
                    _modeBloc.add(ChangeMode(newMode: newMode));
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
                          _newsBloc.add(FetchNewsListEvent());
                        },
                        child: ListContent(),
                      ),
                      NewsPageMode.search => OnBottomScrollWidget(
                        controller: _scrollController,
                        onBottom: () {
                          _searchBloc.add(NextPageSearchEvent());
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