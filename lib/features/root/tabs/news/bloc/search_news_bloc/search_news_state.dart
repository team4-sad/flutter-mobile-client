part of 'search_news_bloc.dart';

sealed class NewsSearchState {
  const NewsSearchState();
}

final class NewsSearchInitial extends NewsSearchState {
  const NewsSearchInitial();
}

sealed class WithSearchResult extends WithPaginationState<NewsModel> implements NewsSearchState {
  final String? searchText;

  WithSearchResult({
    List<NewsModel>? news,
    super.pagination,
    required this.searchText
  }): super(data: news);
}

final class NewsSearchLoading extends WithSearchResult implements NewsSearchState {
  NewsSearchLoading({
    super.news,
    super.pagination,
    super.searchText
  });

  factory NewsSearchLoading.fromState(NewsSearchState otherState) {
    if (otherState is WithSearchResult){
      return NewsSearchLoading(
        news: otherState.data,
        pagination: otherState.pagination,
        searchText: otherState.searchText
      );
    }else {
      return NewsSearchLoading();
    }
  }
}

final class NewsSearchError extends WithSearchResult implements NewsSearchState {

  final Object error;

  NewsSearchError({
    required this.error,
    super.news,
    super.pagination,
    required super.searchText,
  });

  factory NewsSearchError.fromState(Object error, NewsSearchState otherState) {
    if (otherState is WithSearchResult){
      return NewsSearchError(
        error: error,
        news: otherState.data,
        pagination: otherState.pagination,
        searchText: otherState.searchText
      );
    }else {
      return NewsSearchError(
        error: error,
        searchText: ""
      );
    }
  }
}

final class NewsSearchLoaded extends WithSearchResult implements NewsSearchState {
  NewsSearchLoaded({
    required List<NewsModel> news,
    required super.pagination,
    required super.searchText
  });

  factory NewsSearchLoaded.fromState(
    List<NewsModel> newNews,
    PaginationModel pagination,
    String searchText,
    NewsSearchState otherState
  ) {
    if (otherState is WithSearchResult){
      return NewsSearchLoaded(
          news: (otherState.data ?? []) + newNews,
          pagination: pagination,
          searchText: otherState.searchText
      );
    }
    return NewsSearchLoaded(
      news: newNews,
      pagination: pagination,
      searchText: searchText
    );
  }
}
