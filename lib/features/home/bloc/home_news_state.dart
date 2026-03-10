part of 'home_news_cubit.dart';

sealed class HomeNewsState {}

final class HomeNewsInitial extends HomeNewsState {}
final class HomeNewsLoading extends HomeNewsState {}
final class HomeNewsError extends WithErrorState implements HomeNewsState {
  HomeNewsError({required super.error});
}
final class HomeNewsLoaded extends WithAbsoluteDataState<NewsModel> implements HomeNewsState {
  HomeNewsLoaded({required super.data});
}
