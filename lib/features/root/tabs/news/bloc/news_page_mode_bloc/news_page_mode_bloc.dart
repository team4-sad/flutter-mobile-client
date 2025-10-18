
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/root/tabs/news/enum/news_page_mode.dart';

part 'news_page_mode_event.dart';
part 'news_page_mode_state.dart';

class NewsPageModeBloc extends Bloc<NewsPageModeEvent, NewsPageModeState> {
  NewsPageModeBloc() : super(NewsPageModeState(currentMode: NewsPageMode.defaultMode())) {
    on<ChangeMode>((event, emit) {
      if (event.newMode == state.currentMode){
        return;
      }
      emit(NewsPageModeState(currentMode: event.newMode));
    }, transformer: sequential());
  }
}
