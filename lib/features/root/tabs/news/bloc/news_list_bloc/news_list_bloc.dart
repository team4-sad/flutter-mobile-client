import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/features/root/tabs/news/repository/news_repository.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {

  NewsListBloc(INewsRepository repository): super(NewsListInitial()) {
    on<FetchNewsListEvent>((event, emit) async {
      if (state is NewsListError){
        return;
      }
      emit(NewsListLoading.fromState(state));
      try {
        final List<NewsModel> newNews = await repository.fetchNews(
          page: state.nextPage
        );
        emit(NewsListLoaded.fromState(newNews, state.nextPage, state));
      } on Object catch(e){
        emit(NewsListError.fromState(e, state));
      }
    }, transformer: droppable());

    on<RetryFetchNewsListEvent>((event, emit) async {
      if (state is! NewsListError){
        return;
      }
      final current = state as NewsListError;
      emit(NewsListLoading.fromState(current));
      try {
        final currentPage = current.page ?? 1;
        final List<NewsModel> newNews = await repository.fetchNews(
            page: currentPage
        );
        emit(NewsListLoaded.fromState(newNews, currentPage, state));
      } on Object catch(e){
        emit(NewsListError.fromState(e, state));
      }
    }, transformer: droppable());
  }
}
