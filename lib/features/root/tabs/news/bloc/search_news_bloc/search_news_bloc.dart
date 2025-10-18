import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/initial_state.dart';
import 'package:miigaik/features/network-connection/enum/connection_status.dart';
import 'package:miigaik/features/network-connection/exception/no_network_exception.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/root/tabs/news/models/news_pagination_model.dart';
import 'package:miigaik/features/common/bloc/with_pagination_state.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_response_model.dart';
import 'package:miigaik/features/root/tabs/news/repository/search_news_repository.dart';

part 'search_news_event.dart';
part 'search_news_state.dart';

class NewsSearchBloc extends Bloc<SearchNewsEvent, NewsSearchState> {

  final NetworkConnectionService connectionService = GetIt.I.get();
  final ISearchNewsRepository repository = GetIt.I.get();

  NewsSearchBloc() : super(NewsSearchInitial()) {

    connectionService.onConnectionChanged.listen((status){
      if (
        status == ConnectionStatus.exist &&
        state is NewsSearchError &&
        (state as NewsSearchError).error is NoNetworkException
      ){
        add(
          RetrySearchEvent(searchText: (state as NewsSearchError).searchText!)
        );
      }
    });

    on<FetchPageSearchEvent>((event, emit) async {
      if (connectionService.lastStatus != ConnectionStatus.exist){
        emit(NewsSearchError.fromState(NoNetworkException(), state));
        return;
      }
      emit(NewsSearchLoading.fromState(state));
      try {
        final NewsResponseModel response = await repository.searchNews(
            page: event.page,
            searchText: event.searchText
        );
        emit(NewsSearchLoaded.fromState(
            response.news,
            response.pagination,
            event.searchText,
            state
        ));
      } on Object catch(e){
        emit(NewsSearchError.fromState(e, state));
      }
    }, transformer: restartable());

    on<LaunchSearchEvent>((event, emit){
      switch(state){
        case NewsSearchLoaded():
          final s = state as NewsSearchLoaded;
          if (s.nextPage != null) {
            add(FetchPageSearchEvent(page: s.nextPage!, searchText: event.searchText));
          }
        case NewsSearchInitial():
          add(FetchPageSearchEvent(page: 1, searchText: event.searchText));
        case NewsSearchLoading():;
        case NewsSearchError():
          return;
      }
    }, transformer: restartable());

    on<RetrySearchEvent>((event, emit){
      if (state is! NewsSearchError){
        return;
      }
      final current = state as NewsSearchError;
      final currentPage = current.pagination?.currentPage ?? 1;
      add(FetchPageSearchEvent(page: currentPage, searchText: event.searchText));
    }, transformer: restartable());
  }
}
