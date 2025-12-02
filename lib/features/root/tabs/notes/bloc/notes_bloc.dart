import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/use_case/fetch_notes_use_case.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {

  final useCase = FetchNotesUseCase();

  NotesBloc() : super(NotesInitial()) {
    on<FetchNotesEvent>((event, emit) async {
      emit(NotesLoading());
      try {
        final notes = await useCase.fetchNotes();
        emit(NotesLoaded(notes: notes));
      } on Object catch(e){
        emit(NotesError(object: e));
      }
    });
  }
}
