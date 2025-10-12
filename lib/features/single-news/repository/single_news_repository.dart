import 'dart:math';

import 'package:miigaik/features/single-news/models/single_news_model.dart';

abstract class ISingleNewsRepository {
  Future<SingleNewsModel> fetchSingleNews(String newsId);
}

class MockSingleNewsRepository extends ISingleNewsRepository {
  @override
  Future<SingleNewsModel> fetchSingleNews(String newsId) {
    return Future.delayed(
        Duration(seconds: 1),
          () => (Random().nextInt(100) > 10)
            ? SingleNewsModel(
                title: "Студенты МИИГАиК на фестивале \"Открытый город\"",
                htmlContent: """
                  <hr/>
                  <div class="news-item-image">
                  <img alt='Студенты МИИГАиК на фестивале "Открытый город"' src="https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg" title='Студенты МИИГАиК на фестивале "Открытый город"' width="800"/>
                  </div>
                  <hr/>
                  <!-- Об интереснейшем и сложном объекте рассказал его автор, куратор фестиваля, архитектор Тимур Башкаев. -->
                  В рамках фестиваля <a href="http://opencityfest.ru/">«Открытый город»</a> группа градостроителей 5 курса Факультета архитектуры и градостроительства вместе преподавателем по архитектурному и градостроительному проектированию Еленой Ганушкиной посвятила выходные дни изучению города и посетила экскурсию по крупнейшему транспортно-пересадочному узлу Москвы. Об интереснейшем и сложном объекте рассказал его автор, куратор фестиваля, архитектор Тимур Башкаев.
                  <p style="text-align: center;">
                  <img src="upload/images/content-img(227).png"/>
                  </p>
                  <p style="text-align: center;">
                  <img src="upload/images/content-img(226).png"/>
                  </p>
                   ТПУ «Нижегородская» объединяет метро (Некрасовская и БКЛ), МЦК, МЦД, железную дорогу, наземный транспорт и ежедневно обслуживает около 100 тысяч поездок. Это не только пересадочный пункт, но и современное городское пространство с эксплуатируемой кровлей, стеклянным атриумом и озелененной площадью по проекту Arteza. Центральный акцент ансамбля — арт-объект «Московские кольца».
                  <p style="text-align: center;">
                  <img src="upload/images/content-img(229).png"/>
                  </p>
                  <p style="text-align: center;">
                  <img src="upload/images/content-img(228).png"/>
                  </p>
                   На экскурсии студенты МИИГАиК узнали:<br/>
                   - каковы особенности проектирования крупнейшего ТПУ столицы,<br/>
                   - как изменились подходы к созданию подобных объектов за последние годы,<br/>
                   - какие дополнительные функции могут обрести подобные транзитные пространства в будущем.
                  <p style="text-align: center;">
                  <img src="upload/images/content-img(230).png"/>
                  </p>
                  <p style="text-align: center;">
                  <img src="upload/images/content-img(231).png"/>
                  </p>
                   Фотографии: <a href="http://prorus.ru/projects/tpu-nizhegorodskaya-v-moskve/#gallery-13%20">ПРОЕКТ РОССИЯ</a><br/>
                  <br/>
                  """,
                date: "01.10.2025"
              )
            : throw Exception()
    );

  }
}