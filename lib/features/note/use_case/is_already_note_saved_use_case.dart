import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';

class IsAlreadyNoteSavedUseCase {
  final box = GetIt.I.get<Box<NoteModel>>();

  bool isAlreadySaved(NoteModel note) {
    return box.values.contains(note);
  }
}