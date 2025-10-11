part of 'news_list_bloc.dart';

abstract class NewsListState {
  const NewsListState();

  int? get nextPage => 1;
}

abstract class WithDataNewsListState extends NewsListState {
  final List<NewsModel>? news;
  final NewsPaginationModel? pagination;

  const WithDataNewsListState({this.news, this.pagination});

  bool get hasNews => news != null && pagination != null;

  T copyTo<T extends WithDataNewsListState>(T Function(List<NewsModel>?, NewsPaginationModel?) creator) {
    return creator(news, pagination);
  }

  @override
  int? get nextPage => (pagination != null)
    ? (pagination!.hasNext)
      ? pagination!.currentPage + 1
      : null
    : 1;
}

final class NewsListInitial extends NewsListState {
  const NewsListInitial();
}

final class NewsListLoading extends WithDataNewsListState {
  const NewsListLoading({super.news, super.pagination});

  factory NewsListLoading.fromState(NewsListState otherState) {
    if (otherState is WithDataNewsListState){
      return otherState.copyTo((news, pagination) => NewsListLoading(news: news, pagination: pagination));
    }else {
      return NewsListLoading();
    }
  }

}

final class NewsListError extends WithDataNewsListState {

  final Object error;

  const NewsListError({required this.error, super.news, super.pagination});

  factory NewsListError.fromState(Object error, NewsListState otherState) {
    if (otherState is WithDataNewsListState){
      return otherState.copyTo((news, pagination) => NewsListError(
          error: error,
          news: news,
          pagination: pagination
        )
      );
    }else {
      return NewsListError(error: error);
    }
  }
}

final class NewsListLoaded extends WithDataNewsListState {
  const NewsListLoaded({required super.news, required super.pagination});

  factory NewsListLoaded.fromState(
    List<NewsModel> newNews,
    NewsPaginationModel pagination,
    NewsListState otherState
  ) {
    if (otherState is WithDataNewsListState){
      return otherState.copyTo((news, page) => NewsListLoaded(
        news: (news ?? []) + newNews,
        pagination: pagination,
      ));
    }else {
      return NewsListLoaded(news: newNews, pagination: pagination);
    }
  }
}
