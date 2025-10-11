part of 'news_list_bloc.dart';

abstract class NewsListEvent {}

class FetchPageNewsListEvent extends NewsListEvent {
  final int page;

  FetchPageNewsListEvent({required this.page});
}

class FetchNewsListEvent extends NewsListEvent {}

class RetryFetchNewsListEvent extends NewsListEvent {}
