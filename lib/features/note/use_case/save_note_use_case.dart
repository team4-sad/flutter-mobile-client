import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/notes_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';

abstract class ISaveNoteUseCase {
  Future<void> save(NoteModel newNote);
}

class SaveNoteUseCase extends ISaveNoteUseCase {
  final box = GetIt.I.get<Box<NoteModel>>();
  final bloc = GetIt.I.get<NotesBloc>();

  @override
  Future<void> save(NoteModel newNote) async {
    final isUpdate = box.values.contains(newNote);
    if (isUpdate){
      await newNote.save();
    }else{
      box.add(newNote);
    }
    bloc.add(FetchNotesEvent());
  }
}