import 'package:dio/dio.dart';
import 'package:miigaik/features/root/tabs/news/models/news_response_model.dart';

abstract class ISearchNewsRepository {
  Future<NewsResponseModel> searchNews({
    required String searchText,
    int page = 1,
  });
}

class ApiSearchNewsRepository extends ISearchNewsRepository {
  final Dio _dio;

  ApiSearchNewsRepository({required Dio dio}) : _dio = dio;
  @override
  Future<NewsResponseModel> searchNews({
    required String searchText,
    int page = 1,
  }) async {
    var response = await _dio.get(
      "news/search",
      queryParameters: {"page": page, "search_text": searchText},
    );
    return NewsResponseModel.fromJson(response.data);
  }
}
