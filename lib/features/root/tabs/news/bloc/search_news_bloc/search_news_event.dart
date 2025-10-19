part of 'search_news_bloc.dart';

abstract class SearchNewsEvent {}

class FetchPageSearchEvent extends SearchNewsEvent {
  final String searchText;
  final int page;

  FetchPageSearchEvent({
    required this.searchText,
    required this.page
  });
}

class NextPageSearchEvent extends SearchNewsEvent {}

class RetrySearchEvent extends SearchNewsEvent {}

class TypingEvent extends SearchNewsEvent {
  final String searchText;

  TypingEvent({required this.searchText});
}

class DropSearchResult extends SearchNewsEvent {}