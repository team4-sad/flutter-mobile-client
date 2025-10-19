import 'dart:math';

import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_pagination_model.dart';
import 'package:miigaik/features/root/tabs/news/models/news_response_model.dart';

abstract class ISearchNewsRepository {
  Future<NewsResponseModel> searchNews({required String searchText, int page = 1});
}

class MockSearchNewsRepository extends ISearchNewsRepository {
  @override
  Future<NewsResponseModel> searchNews({required String searchText, int page = 1}) {
    return Future.delayed(
        Duration(seconds: 1),
        () => (Random().nextInt(100) > 10) ? NewsResponseModel(
          news: [
            NewsModel(
              id: "0",
              title: "$searchText TEST",
              date: "18.10.2025",
              newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),
            NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),NewsModel(
                id: "0",
                title: "TEST",
                date: "18.10.2025",
                newsLink: "LINK"
            ),




          ],
          pagination: PaginationModel(currentPage: page, hasNext: true)
        ) : throw UnimplementedError()
    );
  }
}