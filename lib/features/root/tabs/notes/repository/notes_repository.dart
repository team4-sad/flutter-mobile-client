import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';

abstract class INotesRepository {
  Future<List<NoteModel>> fetchNotes();
}

class NotesRepository extends INotesRepository {
  
  final box = GetIt.I.get<Box<NoteModel>>();

  @override
  Future<List<NoteModel>> fetchNotes() async {
    return box.values.toList();
  }
}