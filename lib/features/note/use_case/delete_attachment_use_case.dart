import 'package:get_it/get_it.dart';
import 'package:miigaik/features/note/repositories/attachment_repository.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';

class DeleteAttachmentUseCase {
  final repository = GetIt.I.get<INoteAttachmentRepository>();

  Future<void> removeAttachment(NoteModel note) async {
    await repository.removeAttachment(note);
  }
}