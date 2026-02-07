import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/repository/notes_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {

  final _repository = GetIt.I.get<INotesRepository>();

  NotesBloc() : super(NotesInitial()) {
    on<FetchNotesEvent>((event, emit) async {
      emit(NotesLoading());
      try {
        final notes = await _repository.fetchNotes();
        emit(NotesLoaded(notes: notes));
      } on Object catch(e){
        emit(NotesError(object: e));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      if (state is! NotesLoaded){
        return;
      }
      final s = state as NotesLoaded;

      try {
        await _repository.deleteNote(event.note);
      } on Object catch(e){
        emit(NotesError(object: e));
      }

      final notes = s.notes..remove(event.note);
      emit(NotesLoaded(notes: notes));
    });
  }
}
