part of 'notes_bloc.dart';

sealed class NotesEvent {}

final class FetchNotesEvent extends NotesEvent {}

final class DeleteNoteEvent extends NotesEvent {
  final NoteModel note;

  DeleteNoteEvent({required this.note});
}
