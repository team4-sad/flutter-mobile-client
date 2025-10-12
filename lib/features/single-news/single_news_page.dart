import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/single-news/content/loading_single_news_content.dart';
import 'package:miigaik/features/single-news/widgets/news_html_widget.dart';
import 'package:miigaik/features/single-news/widgets/single_news_app_bar.dart';
import 'package:miigaik/features/single-news/widgets/top_single_news_widget.dart';

import 'bloc/single_news_bloc.dart';

class SingleNewsPage extends StatelessWidget {

  final String newsId;

  SingleNewsPage({super.key, required this.newsId});

  final bloc = GetIt.I.get<SingleNewsBloc>();

  void _addFetchSingleNews(){
    bloc.add(FetchSingleNewsEvent(newsId: newsId));
  }

  @override
  Widget build(BuildContext context) {
    _addFetchSingleNews();
    return Scaffold(
      appBar: SingleNewsAppBar(),
      body: BlocBuilder<SingleNewsBloc, SingleNewsState>(
        bloc: GetIt.I.get(),
        builder: (context, state) {
          switch (state){
            case SingleNewsLoadedState():
              return CustomScrollView(
                slivers: [
                  TopSingleNewsWidget().s(),
                  20.svs(),
                  NewsHtmlWidget(html: state.singleNews.htmlContent).sp(25.horizontal())
                ],
              );
            case SingleNewsErrorState():
              return Center(
                child: PlaceholderWidget.fromException(state.error, (){
                  _addFetchSingleNews();
                })
              );
            case SingleNewsInitialState():
            case SingleNewsLoadingState():
              return LoadingSingleNewsContent();
          }
        },
      ),
    );
  }
}