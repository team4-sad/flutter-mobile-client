

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_pagination_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_response_model.dart';

abstract class INewsRepository {
  Future<NewsResponseModel> fetchNews({int page = 1});
}

class ApiNewsRepository extends INewsRepository {
  final String _baseApiUrl;
  final Dio _dio;

  ApiNewsRepository({
    required Dio dio,
    required String baseApiUrl,
  }) : _dio = dio, _baseApiUrl = baseApiUrl;

  @override
  Future<NewsResponseModel> fetchNews({int page = 1}) async {
    throw UnimplementedError();
  }
}

class MockNewsRepository extends INewsRepository {
  @override
  Future<NewsResponseModel> fetchNews({int page = 1}) {
    return Future.delayed(
      Duration(seconds: 1),
      () => Random().nextInt(100) > 10 ? NewsResponseModel(
        news: fakeData,
        pagination: NewsPaginationModel(currentPage: page, hasNext: page < 5)
        // news: [],
        // pagination: NewsPaginationModel(currentPage: 1, hasNext: false)
      ) : throw Exception()
    );
  }
  
  final fakeData = [
    NewsModel(
        id: "6604",
        title: "1 Студенты МИИГАиК на фестивале \"Открытый город\"",
        description: "Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        imageLink: "https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "2 Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        imageLink: "https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "3 Студенты МИИГАиК на фестивале \"Открытый город\"",
        description: "Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "4 Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "5 Студенты МИИГАиК на фестивале \"Открытый город\"",
        description: "Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        imageLink: "https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "6 Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        imageLink: "https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "7 Студенты МИИГАиК на фестивале \"Открытый город\"",
        description: "Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "8 Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "9 Студенты МИИГАиК на фестивале \"Открытый город\"",
        description: "Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
    NewsModel(
        id: "6604",
        title: "10 Студенты МИИГАиК на фестивале \"Открытый город\"",
        date: "22.09.2025",
        newsLink: "https://www.miigaik.ru/about/news/6604/"
    ),
  ];
}