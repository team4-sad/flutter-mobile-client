part of 'single_news_bloc.dart';

abstract class SingleNewsEvent {}

final class FetchSingleNewsEvent extends SingleNewsEvent {
  final String newsId;

  FetchSingleNewsEvent({required this.newsId});
}
