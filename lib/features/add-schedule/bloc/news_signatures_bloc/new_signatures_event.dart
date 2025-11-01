part of 'new_signatures_bloc.dart';

abstract class NewSignaturesEvent {
  const NewSignaturesEvent();
}

class FetchNewSignaturesEvent extends NewSignaturesEvent {
  final String searchText;
  final SignatureScheduleType searchType;

  FetchNewSignaturesEvent({required this.searchText, required this.searchType});
}

class ClearNewSignaturesEvent extends NewSignaturesEvent {}
