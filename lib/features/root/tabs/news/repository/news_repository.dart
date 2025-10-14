import 'package:dio/dio.dart';
import 'package:miigaik/features/root/tabs/news/models/news_response_model.dart';

abstract class INewsRepository {
  Future<NewsResponseModel> fetchNews({int page = 1});
}

class ApiNewsRepository extends INewsRepository {
  final Dio _dio;

  ApiNewsRepository({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<NewsResponseModel> fetchNews({int page = 1}) async {
    var response = await _dio.get("news", queryParameters: {"page": page});
    return NewsResponseModel.fromJson(response.data);
  }
}