import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_pagination_model.dart';

class NewsResponseModel {
  final List<NewsModel> news;
  final PaginationModel pagination;

  NewsResponseModel({required this.news, required this.pagination});

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) => NewsResponseModel(
    news: (json["news_list"]! as List).map((e) => NewsModel.fromJson(e)).toList(),
    pagination: PaginationModel.fromJson(json["pagination"])
  );
}