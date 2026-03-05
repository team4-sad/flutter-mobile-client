part of 'search_notes_bloc.dart';

sealed class SearchNotesState {}

final class SearchNotesInitial extends SearchNotesState {}

final class SearchNotesLoadingState extends SearchNotesState {
  final String searchText;

  SearchNotesLoadingState({required this.searchText});
}

final class SearchNotesLoadedState extends WithDataState<NoteModel> implements SearchNotesState  {
  final String searchText;

  SearchNotesLoadedState({required this.searchText, required super.data});
}

final class SearchNotesErrorState extends SearchNotesState {
  final String searchText;
  final Object error;

  SearchNotesErrorState({required this.searchText, required this.error});
}