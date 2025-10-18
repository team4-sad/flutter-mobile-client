import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/initial_state.dart';
import 'package:miigaik/features/common/bloc/pagination_error_state.dart';
import 'package:miigaik/features/common/bloc/pagination_loading_state.dart';
import 'package:miigaik/features/common/other/debouncer.dart';
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
  final _debouncer = Debouncer(duration: Duration(milliseconds: 500));

  NewsSearchBloc() : super(NewsSearchInitial()) {

    connectionService.onConnectionChanged.listen((status){
      if (
        status == ConnectionStatus.exist &&
        state is NewsSearchError &&
        (state as NewsSearchError).error is NoNetworkException
      ){
        add(RetrySearchEvent());
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
        if (state is NewsSearchLoading){
          emit(NewsSearchLoaded.fromState(
              response.news,
              response.pagination,
              event.searchText,
              state
          ));
        }
      } on Object catch(e){
        emit(NewsSearchError.fromState(e, state));
      }
    }, transformer: restartable());

    on<TypingEvent>((event, emit){
      if (event.searchText.isEmpty){
        emit(NewsSearchInitial());
        _debouncer.cancel();
        return;
      }else if (state is! NewsSearchLoading) {
        emit(NewsSearchLoading());
      }
      _debouncer(() {
        add(FetchPageSearchEvent(searchText: event.searchText, page: 1));
      });
    }, transformer: restartable());

    on<RetrySearchEvent>((event, emit){
      if (state is! NewsSearchError){
        return;
      }
      final current = state as NewsSearchError;
      final currentPage = current.pagination?.currentPage ?? 1;
      if (current.searchText != null){
        add(FetchPageSearchEvent(page: currentPage, searchText: current.searchText!));
      }
    }, transformer: restartable());

    on<NextPageSearchEvent>((event, emit) {
      if (state is! NewsSearchLoaded) {
        return;
      }
      final s = state as NewsSearchLoaded;
      if (s.hasInvalid){
        emit(
          NewsSearchError(
            error: ArgumentError(
              "Invalid NewsSearchLoaded state - pagination is null"
            ),
            searchText: ""
          )
        );
        return;
      }
      if (s.pagination!.hasNext) {
        add(FetchPageSearchEvent(
          searchText: s.searchText!,
          page: s.pagination!.currentPage + 1
        ));
      }
    });
  }
}
