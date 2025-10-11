part of 'news_list_bloc.dart';

abstract class NewsListEvent {}

class FetchNewsListEvent extends NewsListEvent {}

class RetryFetchNewsListEvent extends NewsListEvent {}
