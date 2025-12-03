import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/use_case/delete_note_use_case.dart';
import 'package:miigaik/features/root/tabs/notes/use_case/fetch_notes_use_case.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {

  final fetchUseCase = FetchNotesUseCase();
  final deleteUseCase = DeleteNoteUseCase();

  NotesBloc() : super(NotesInitial()) {
    on<FetchNotesEvent>((event, emit) async {
      emit(NotesLoading());
      try {
        final notes = await fetchUseCase.fetchNotes();
        emit(NotesLoaded(notes: notes));
      } on Object catch(e){
        emit(NotesError(object: e));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      if (state is! NotesLoaded){
        return;
      }

      try {
        final notes = await fetchUseCase.fetchNotes();
        emit(NotesLoaded(notes: notes));
      } on Object catch(e){
        emit(NotesError(object: e));
      }

      deleteUseCase.deleteNote(event.note);
      final notes = (state as NotesLoaded).notes..remove(event.note);
      emit(NotesLoaded(notes: notes));
    });
  }
}
