import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/with_data_state.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/repository/notes_repository.dart';

part 'search_notes_event.dart';
part 'search_notes_state.dart';

class SearchNotesBloc extends Bloc<SearchNotesEvent, SearchNotesState> {

  final INotesRepository notesRepository = GetIt.I.get();

  SearchNotesBloc() : super(SearchNotesInitial()) {
    on<SearchNotesTextChangedEvent>((event, emit) {
      try {
        final data = notesRepository.searchNotes(event.text);
        emit(SearchNotesLoadedState(data: data, searchText: event.text));
      } on Object catch (e) {
        emit(SearchNotesErrorState(error: e, searchText: event.text));
      }
    }, transformer: debounce(Duration(milliseconds: 400)));

    on<ClearSearchNotesEvent>((event, emit) {
      emit(SearchNotesInitial());
    });
  }
}
