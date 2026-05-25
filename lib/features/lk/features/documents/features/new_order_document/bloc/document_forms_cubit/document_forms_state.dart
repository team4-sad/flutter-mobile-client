part of 'document_forms_cubit.dart';

sealed class DocumentFormsState {}

final class DocumentFormsInitial extends DocumentFormsState {}
final class DocumentFormsLoading extends DocumentFormsState {}
final class DocumentFormsLoaded extends WithAbsoluteDataState<DocumentFormModel> implements DocumentFormsState {
  DocumentFormsLoaded({required super.data});
}
final class DocumentFormsError extends WithErrorState implements DocumentFormsState {
  DocumentFormsError({required super.error});
}

