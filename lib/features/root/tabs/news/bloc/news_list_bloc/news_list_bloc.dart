import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/network-connection/enum/connection_status.dart';
import 'package:miigaik/features/network-connection/exception/no_network_exception.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_pagination_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_response_model.dart';
import 'package:miigaik/features/root/tabs/news/repository/news_repository.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {

  final NetworkConnectionService connectionService = GetIt.I.get();

  NewsListBloc(
    INewsRepository repository,
  ): super(NewsListInitial()) {

    connectionService.onConnectionChanged.listen((status){
      if (
        status == ConnectionStatus.exist &&
        state is NewsListError &&
        (state as NewsListError).error is NoNetworkException
      ){
        add(RetryFetchNewsListEvent());
      }
    });

    on<FetchPageNewsListEvent>((event, emit) async {
      if (connectionService.lastStatus != ConnectionStatus.exist){
        emit(NewsListError.fromState(NoNetworkException(), state));
        return;
      }
      emit(NewsListLoading.fromState(state));
      try {
        final NewsResponseModel response = await repository.fetchNews(
            page: event.page
        );
        emit(NewsListLoaded.fromState(response.news, response.pagination, state));
      } on Object catch(e){
        emit(NewsListError.fromState(e, state));
      }
    }, transformer: droppable());

    on<FetchNewsListEvent>((event, emit) async {
      if (state is! NewsListInitial && state is! NewsListLoaded){
        return;
      }
      if (state.nextPage != null) {
        add(FetchPageNewsListEvent(page: state.nextPage!));
      }
    }, transformer: droppable());

    on<RetryFetchNewsListEvent>((event, emit) async {
      if (state is! NewsListError){
        return;
      }
      final current = state as NewsListError;
      final currentPage = current.pagination?.currentPage ?? 1;
      add(FetchPageNewsListEvent(page: currentPage));
    }, transformer: droppable());
  }
}
