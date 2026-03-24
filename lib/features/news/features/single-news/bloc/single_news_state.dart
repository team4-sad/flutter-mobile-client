part of 'single_news_bloc.dart';

sealed class SingleNewsState {}

final class SingleNewsInitialState extends SingleNewsState {}

final class SingleNewsLoadingState extends SingleNewsState {}

final class SingleNewsErrorState extends SingleNewsState {
  final Object error;

  SingleNewsErrorState({required this.error});
}

final class SingleNewsLoadedState extends SingleNewsState {
  final SingleNewsModel singleNews;

  SingleNewsLoadedState({required this.singleNews});
}
