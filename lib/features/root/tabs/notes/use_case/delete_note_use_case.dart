import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/repository/notes_repository.dart';

class DeleteNoteUseCase {
  final repository = GetIt.I.get<INotesRepository>();

  Future<void> deleteNote(NoteModel note) async {
    await repository.deleteNote(note);
  }
}