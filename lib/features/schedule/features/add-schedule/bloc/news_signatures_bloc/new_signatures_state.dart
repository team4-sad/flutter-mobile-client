part of 'new_signatures_bloc.dart';

sealed class NewSignaturesState {
  const NewSignaturesState();
}

final class NewSignaturesInitial extends NewSignaturesState {}

final class NewSignaturesLoading extends NewSignaturesState {
  final String searchText;
  final SignatureScheduleType searchType;

  const NewSignaturesLoading({
    required this.searchText,
    required this.searchType,
  });
}

final class NewSignaturesError extends WithErrorState
    implements NewSignaturesState {

  final String searchText;
  final SignatureScheduleType searchType;

  NewSignaturesError({required super.error, required this.searchText, required this.searchType});
}

final class NewSignaturesLoaded extends WithDataState<SignatureScheduleModel>
    implements NewSignaturesState {
  NewSignaturesLoaded({required super.data});
      
}
