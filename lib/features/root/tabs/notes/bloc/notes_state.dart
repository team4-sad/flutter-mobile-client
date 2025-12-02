part of 'notes_bloc.dart';

sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<NoteModel> notes;

  NotesLoaded({required this.notes});
}

final class NotesError extends NotesState {
  final Object object;

  NotesError({required this.object});
}
