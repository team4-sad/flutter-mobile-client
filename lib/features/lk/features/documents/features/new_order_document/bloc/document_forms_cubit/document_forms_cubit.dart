import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/features/lk/features/documents/models/document_form_model.dart';
import 'package:miigaik/features/lk/features/documents/use_case/get_documents_forms_use_case.dart';

part 'document_forms_state.dart';

class DocumentFormsCubit extends Cubit<DocumentFormsState> {
  DocumentFormsCubit() : super(DocumentFormsInitial());

  final useCase = GetIt.I.get<GetDocumentsFormsUseCase>();

  void fetchFormsDocument() async {
    try {
      emit(DocumentFormsLoading());
      final response = await useCase();
      emit(DocumentFormsLoaded(data: response));
    } on Object catch(e){
      emit(DocumentFormsError(error: e));
    }
  }
}
