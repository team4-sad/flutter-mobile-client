import 'package:dio/dio.dart';
import 'package:miigaik/features/single-news/models/single_news_model.dart';

abstract class ISingleNewsRepository {
  Future<SingleNewsModel> fetchSingleNews(String newsId);
}

class ApiSingleNewsRepository extends ISingleNewsRepository {

  final Dio _dio;

  ApiSingleNewsRepository({required Dio dio}) : _dio = dio;

  @override
  Future<SingleNewsModel> fetchSingleNews(String newsId) async {
    final response = await _dio.get("news/$newsId");
    return SingleNewsModel.fromJson(response.data);
  }
}