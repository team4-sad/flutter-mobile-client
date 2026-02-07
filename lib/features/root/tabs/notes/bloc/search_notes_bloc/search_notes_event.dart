part of 'search_notes_bloc.dart';

sealed class SearchNotesEvent {}

final class SearchNotesTextChangedEvent extends SearchNotesEvent {
  final String text;

  SearchNotesTextChangedEvent({required this.text});
}

final class ClearSearchNotesEvent extends SearchNotesEvent {}