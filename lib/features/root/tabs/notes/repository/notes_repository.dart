import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';

abstract class INotesRepository {
  Future<List<NoteModel>> fetchNotes();
  List<NoteModel> searchNotes(String text);
  Future<void> deleteNote(NoteModel note);
}

class NotesRepository extends INotesRepository {
  
  final Box<NoteModel> box;

  NotesRepository({required this.box});

  @override
  Future<List<NoteModel>> fetchNotes() async {
    return box.values.toList();
  }

  @override
  Future<void> deleteNote(NoteModel note) async {
    await note.delete();
  }

  @override
  List<NoteModel> searchNotes(String text) {
    final List<NoteModel> notes = box.values.toList();
    return notes.where((note) => note.title.contains(text)).toList();
  }
}