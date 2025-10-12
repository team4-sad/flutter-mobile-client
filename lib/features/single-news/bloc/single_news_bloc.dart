import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/single-news/models/single_news_model.dart';
import 'package:miigaik/features/single-news/repository/single_news_repository.dart';

part 'single_news_event.dart';
part 'single_news_state.dart';

class SingleNewsBloc extends Bloc<SingleNewsEvent, SingleNewsState> {

  final ISingleNewsRepository _repository = GetIt.I.get();

  SingleNewsBloc() : super(SingleNewsInitialState()) {
    on<FetchSingleNewsEvent>((event, emit) async {
      emit(SingleNewsLoadingState());
      try {
        final singleNews = await _repository.fetchSingleNews(event.newsId);
        emit(SingleNewsLoadedState(singleNews: singleNews));
      } on Object catch(e) {
        emit(SingleNewsErrorState(error: e));
      }
    });
  }
}
