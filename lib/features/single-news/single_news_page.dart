import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleNewsPage extends StatelessWidget {
  const SingleNewsPage({super.key});

  void showZoomableImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          tightMode: true,
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
      barrierColor: Colors.black87,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.palette.background,
        surfaceTintColor: context.palette.background,
        leadingWidth: 70,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(I.back, color: context.palette.subText,),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          Text(
            "01.10.2025", style: TS.light15.use(context.palette.text)
          ).sp(25.horizontal()),
          4.svs(),
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 10,
                  decoration: BoxDecoration(
                    color: context.palette.accent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.r),
                      bottomRight: Radius.circular(5.r),
                    )
                  ),
                ),
                Text(
                  "Студенты МИИГАиК на фестивале \"Открытый город\"",
                  style: TS.medium20.use(context.palette.text)
                ).p(15.horizontal()).e(),
              ],
            ),
          ).s(),
          20.svs(),
          HtmlWidget(
            """
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
            enableCaching: true,
            baseUrl: Uri(host: "www.miigaik.ru", scheme: "https"),
            customStylesBuilder: (element) {
              if (element.className == "news-item-image"){
                return {
                  "margin-bottom": "10px"
                };
              }
              if (element.localName == "hr"){
                return {
                  "display": "none"
                };
              }
              if (element.localName == "img"){
                return {
                  "border-radius": "15px"
                };
              }
              return null;
            },
            textStyle: TS.light15,
            onTapImage: (metadata) async {
              final image = metadata.sources.firstOrNull;
              if (image != null){
                showZoomableImageDialog(context, image.url);
              }
            },
            onTapUrl: (rawUrl) async {
              final Uri url = Uri.parse(rawUrl);
              return !await launchUrl(url);
            },
            onLoadingBuilder: (context, _, __){
              return AppShimmer(width: 1.sw, height: 180);
            },
          ).sp(25.horizontal())
        ],
      ),
    );
  }
}