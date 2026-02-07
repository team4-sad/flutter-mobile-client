import 'package:easy_localization/easy_localization.dart';
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
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/values.dart';

import 'bloc/news_list_bloc/news_list_bloc.dart';
import 'bloc/news_page_mode_bloc/news_page_mode_bloc.dart';
import '../../../common/widgets/header.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _listScrollController = ScrollController();
  final _searchScrollController = ScrollController();

  final _textEditingController = TextEditingController();
  bool _showDivider = false;

  final NewsListBloc _newsBloc = GetIt.I.get();
  final NewsSearchBloc _searchBloc = GetIt.I.get();
  final NewsPageModeBloc _modeBloc = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _newsBloc.add(FetchNewsListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<NewsPageModeBloc, NewsPageModeState>(
          bloc: _modeBloc,
          listener: (context, state){
            _refreshDivider(state);
          },
          builder: (context, state) {
            return Column(
              children: [
                Header(
                  title: S.news_title.tr(),
                  hint: S.news_search.tr(),
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
                  child: IndexedStack(
                    index: state.currentMode.index,
                    children: [
                      OnScrollWidget(
                        onBottom: () {
                          _newsBloc.add(FetchNewsListEvent());
                        },
                        onTop: (){
                          setState(() {
                            setState(() => _showDivider = false);
                          });
                        },
                        onNotTop: (){
                          setState(() {
                            setState(() => _showDivider = true);
                          });
                        },
                        child: CustomScrollView(
                          controller: _listScrollController,
                          slivers: [
                            ListContent(),
                          ],
                        ),
                      ),
                      OnScrollWidget(
                        onTop: (){
                          setState(() => _showDivider = false);
                        },
                        onNotTop: (){
                          setState(() => _showDivider = true);
                        },
                        onBottom: () {
                          _searchBloc.add(NextPageSearchEvent());
                        },
                        child: CustomScrollView(
                          controller: _searchScrollController,
                          slivers: [
                            SearchContent()
                          ],
                        ),
                      )
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
    _listScrollController.dispose();
    _searchScrollController.dispose();
    super.dispose();
  }

  void _refreshDivider(NewsPageModeState state) {
    switch(state.currentMode){
      case NewsPageMode.list:
        _updateDivider(_listScrollController);
      case NewsPageMode.search:
        _updateDivider(_searchScrollController);
    }
  }

  void _updateDivider(ScrollController controller){
    final isScroll = controller.offset > 0;
    if (isScroll != _showDivider) {
      setState(() => _showDivider = isScroll);
    }
  }
}