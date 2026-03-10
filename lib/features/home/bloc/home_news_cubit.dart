import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/features/news/models/news_model.dart';
import 'package:miigaik/features/news/repository/news_repository.dart';

part 'home_news_state.dart';

class HomeNewsCubit extends Cubit<HomeNewsState> {
  HomeNewsCubit() : super(HomeNewsInitial());

  final INewsRepository repository = GetIt.I.get();

  Future<void> fetchNews() async {
    try {
      emit(HomeNewsLoading());
      final response = await repository.fetchNews();
      emit(HomeNewsLoaded(data: response.news));
    } on Object catch(e){
      emit(HomeNewsError(error: e));
    }
  }
}
