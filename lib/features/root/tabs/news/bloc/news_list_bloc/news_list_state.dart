part of 'news_list_bloc.dart';

sealed class NewsListState {
  const NewsListState();
}

final class NewsListInitial extends NewsListState {
  const NewsListInitial();
}

final class NewsListLoading extends PaginationLoadingState<NewsModel> implements NewsListState {
  NewsListLoading({
    super.data,
    super.pagination
  });

  factory NewsListLoading.fromState(NewsListState otherState) {
    if (otherState is WithPaginationState<NewsModel>){
      final s = otherState as WithPaginationState<NewsModel>;
      return NewsListLoading(
        data: s.data,
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
    super.data,
    super.pagination
  });

  factory NewsListError.fromState(Object error, NewsListState otherState) {
    if (otherState is WithPaginationState<NewsModel>){
      final s = otherState as WithPaginationState<NewsModel>;
      return NewsListError(
        error: error,
        data: s.data,
        pagination: s.pagination
      );
    }else {
      return NewsListError(error: error);
    }
  }
}

final class NewsListLoaded extends WithPaginationState<NewsModel> implements NewsListState {
  NewsListLoaded({
    required super.data,
    required super.pagination
  });

  factory NewsListLoaded.fromState(
    List<NewsModel> newNews,
    PaginationModel pagination,
    NewsListState otherState
  ) {
    if (otherState is WithPaginationState){
      final s = otherState as WithPaginationState<NewsModel>;
      return NewsListLoaded(
        data: (s.data ?? []) + newNews,
        pagination: pagination
      );
    }else {
      return NewsListLoaded(data: newNews, pagination: pagination);
    }
  }
}
