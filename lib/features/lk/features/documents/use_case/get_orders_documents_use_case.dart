import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/features/documents/models/order_document_model.dart';
import 'package:miigaik/features/lk/features/documents/repository/documents_repository.dart';

class GetOrdersDocumentsUseCase {
  final IDocumentsRepository documentsRepository;

  GetOrdersDocumentsUseCase({IDocumentsRepository? documentsRepository}):
    documentsRepository = documentsRepository ?? GetIt.I.get();

  Future<List<OrderDocumentModel>> call(){
    return documentsRepository.getOrders();
  }
}