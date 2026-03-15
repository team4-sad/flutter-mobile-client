import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/extensions/widget_extension.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/features/home/bloc/home_news_cubit.dart';
import 'package:miigaik/features/home/widgets/home_menu_widget.dart';
import 'package:miigaik/features/home/widgets/news_slider.dart';
import 'package:miigaik/features/news/news_page.dart';
import 'package:miigaik/features/other-services/other_services_page.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeNewsCubit();
    cubit.fetchNews();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paddingTopPage.vs(),
            Text(
              "Главная",
              style: TS.medium23.use(context.palette.text)
            ).p(horizontalPaddingPage.horizontal()),
            20.vs(),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage())
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Новости", style: TS.medium15.use(context.palette.text)),
                  Text("Читать все", style: TS.medium12.use(context.palette.subText))
                ],
              ).p(horizontalPaddingPage.horizontal()),
            ),
            10.vs(),
            BlocBuilder<HomeNewsCubit, HomeNewsState>(
              bloc: cubit,
              builder: (context, state){
                switch(state){
                  case HomeNewsInitial():
                  case HomeNewsLoading():
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPaddingPage
                      ),
                      child: AppShimmer.container(height: 226),
                    );
                  case HomeNewsError(error: var err):
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PlaceholderWidget.fromException(
                          err, () {
                            cubit.fetchNews();
                          }
                        ),
                      ],
                    );
                  case HomeNewsLoaded(data: var news):
                    return NewsSlider(news: news);
                }
              }
            ),
            20.vs(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Вас может заинтересовать", style: TS.medium15.use(context.palette.text)),
                  12.vs(),
                  HomeMenuWidget(
                    indexSep: 2,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.palette.container,
                          image: DecorationImage(
                            image: AssetImage("assets/images/home_services.png"),
                            fit: BoxFit.fill
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: Text("Услуги", style: TS.medium15.use(context.palette.text)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.palette.subText,
                          image: DecorationImage(
                              image: AssetImage("assets/images/home_events.png"),
                              fit: BoxFit.fill
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 17),
                            child: Text("Мероприятия", style: TS.medium15.use(context.palette.unAccent)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.palette.subText,
                          image: DecorationImage(
                            image: AssetImage("assets/images/home_mugs.png"),
                            fit: BoxFit.fill
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 23),
                            child: Text("Кружки", style: TS.medium15.use(context.palette.unAccent)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherServicesPage()
                            )
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.palette.container,
                            image: DecorationImage(
                                image: AssetImage("assets/images/home_other_services.png"),
                                fit: BoxFit.fill
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: 18),
                              child: Text("Другие сервисы", style: TS.medium15.use(context.palette.text)),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  heightAreaBottomNavBar.vs()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}