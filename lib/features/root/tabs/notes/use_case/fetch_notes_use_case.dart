import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/repository/notes_repository.dart';

class FetchNotesUseCase {
  final repository = GetIt.I.get<INotesRepository>();

  Future<List<NoteModel>> fetchNotes() async {
    final notes = await repository.fetchNotes();
    return notes;
  }
}