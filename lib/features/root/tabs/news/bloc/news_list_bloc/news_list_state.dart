part of 'news_list_bloc.dart';

sealed class NewsListState {
  const NewsListState();
}

final class NewsListInitial extends NewsListState {
  const NewsListInitial();
}

final class NewsListLoading extends WithPaginationState<NewsModel> implements NewsListState {
  NewsListLoading({
    List<NewsModel>? news,
    super.pagination
  }): super(data: news);

  factory NewsListLoading.fromState(NewsListState otherState) {
    if (otherState is WithPaginationState<NewsModel>){
      final s = otherState as WithPaginationState<NewsModel>;
      return NewsListLoading(
        news: s.data,
        pagination: s.pagination
      );
    }else {
      return NewsListLoading();
    }
  }
}

final class NewsListError extends WithPaginationState<NewsModel> implements NewsListState {

  final Object error;

  NewsListError({
    required this.error,
    List<NewsModel>? news,
    super.pagination
  }): super(data: news);

  factory NewsListError.fromState(Object error, NewsListState otherState) {
    if (otherState is WithPaginationState<NewsModel>){
      final s = otherState as WithPaginationState<NewsModel>;
      return NewsListError(
          error: error,
          news: s.data,
          pagination: s.pagination
      );
    }else {
      return NewsListError(error: error);
    }
  }
}

final class NewsListLoaded extends WithPaginationState<NewsModel> implements NewsListState {
  NewsListLoaded({
    required List<NewsModel> news,
    required super.pagination
  }): super(data: news);

  factory NewsListLoaded.fromState(
    List<NewsModel> newNews,
    PaginationModel pagination,
    NewsListState otherState
  ) {
    if (otherState is WithPaginationState){
      final s = otherState as WithPaginationState<NewsModel>;
      return NewsListLoaded(
        news: (s.data ?? []) + newNews,
        pagination: pagination
      );
    }else {
      return NewsListLoaded(news: newNews, pagination: pagination);
    }
  }
}
