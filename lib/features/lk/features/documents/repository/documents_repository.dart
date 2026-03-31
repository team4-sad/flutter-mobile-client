import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/features/documents/models/document_form_model.dart';
import 'package:miigaik/features/lk/features/documents/models/order_document_model.dart';

abstract class IDocumentsRepository {
  Future<List<OrderDocumentModel>> getOrders();
  Future<List<DocumentFormModel>> getDocumentsForms();
}

class ApiDocumentsRepository extends IDocumentsRepository {

  final Dio _dio;

  ApiDocumentsRepository({Dio? dio}) : _dio = dio ?? GetIt.I.get();

  @override
  Future<List<DocumentFormModel>> getDocumentsForms() async {
    final response = await _dio.get("lk/document/forms", options: Options(
      headers: {
        "Authorization": ""
      }
    ));
    final data = response.data as List;
    return data.map((e) => DocumentFormModel.fromJson(e)).toList();
  }

  @override
  Future<List<OrderDocumentModel>> getOrders() async {
    final response = await _dio.get("lk/document/orders", options: Options(
      headers: {
        "Authorization": ""
      }
    ));
    final data = response.data as List;
    return data.map((e) => OrderDocumentModel.fromJson(e)).toList();
  }
}