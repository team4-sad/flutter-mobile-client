part of 'news_list_bloc.dart';

abstract class NewsListState {
  const NewsListState();

  int get nextPage => 1;
}

abstract class WithDataNewsListState extends NewsListState {
  final List<NewsModel>? news;
  final int? page;

  const WithDataNewsListState({this.news, this.page});

  bool get hasNews => news != null && page != null;

  T copyTo<T extends WithDataNewsListState>(T Function(List<NewsModel>?, int?) creator) {
    return creator(news, page);
  }

  @override
  int get nextPage => (page ?? 0) + 1;
}

final class NewsListInitial extends NewsListState {
  const NewsListInitial();
}

final class NewsListLoading extends WithDataNewsListState {
  const NewsListLoading({super.news, super.page});

  factory NewsListLoading.fromState(NewsListState otherState) {
    if (otherState is WithDataNewsListState){
      return otherState.copyTo((news, page) => NewsListLoading(news: news, page: page));
    }else {
      return NewsListLoading();
    }
  }

}

final class NewsListError extends WithDataNewsListState {

  final Object error;

  const NewsListError({required this.error, super.news, super.page});

  factory NewsListError.fromState(Object error, NewsListState otherState) {
    if (otherState is WithDataNewsListState){
      return otherState.copyTo((news, page) => NewsListError(
          error: error,
          news: news,
          page: page
        )
      );
    }else {
      return NewsListError(error: error);
    }
  }
}

final class NewsListLoaded extends WithDataNewsListState {
  const NewsListLoaded({required super.news, required super.page});

  factory NewsListLoaded.fromState(
    List<NewsModel> newNews,
    int newPage,
    NewsListState otherState
  ) {
    if (otherState is WithDataNewsListState){
      return otherState.copyTo((news, page) => NewsListLoaded(
        news: (news ?? []) + newNews,
        page: newPage,
      ));
    }else {
      return NewsListLoaded(news: newNews, page: newPage);
    }
  }
}
