import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:miigaik/features/note/repositories/attachment_repository.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';

class AddAttachmentUseCase {

  final repository = GetIt.I.get<INoteAttachmentRepository>();

  Future<void> addAttachment(File file, NoteModel note){
    return repository.addAttachment(file, note);
  }
}