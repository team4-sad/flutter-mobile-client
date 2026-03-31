import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/features/documents/models/document_form_model.dart';
import 'package:miigaik/features/lk/features/documents/repository/documents_repository.dart';

class GetDocumentsFormsUseCase {
  final IDocumentsRepository documentsRepository;

  GetDocumentsFormsUseCase({IDocumentsRepository? documentsRepository}):
    documentsRepository = documentsRepository ?? GetIt.I.get();

  Future<List<DocumentFormModel>> call() {
    return documentsRepository.getDocumentsForms();
  }
}