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

class LaunchSearchEvent extends SearchNewsEvent {
  final String searchText;

  LaunchSearchEvent({required this.searchText});
}

class RetrySearchEvent extends SearchNewsEvent {
  final String searchText;

  RetrySearchEvent({required this.searchText});
}