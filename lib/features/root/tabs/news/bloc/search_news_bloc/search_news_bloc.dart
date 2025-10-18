import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/root/tabs/news/bloc/news_list_bloc/news_list_bloc.dart';

part 'search_news_event.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, NewsListState> {
  SearchNewsBloc() : super(NewsListInitial()) {
    on<FetchPageSearchEvent>((event, emit) {

    });

    on<LaunchSearchEvent>((event, emit){

    });

    on<RetrySearchEvent>((event, emit){

    });
  }
}
