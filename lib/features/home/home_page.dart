import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/extensions/widget_extension.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/features/home/bloc/home_news_cubit.dart';
import 'package:miigaik/features/home/widgets/news_slider.dart';
import 'package:miigaik/features/news/news_page.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeNewsCubit();
    cubit.fetchNews();

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Главная",
              style: TS.medium23.use(context.palette.text)
            ).p(horizontalPaddingPage.horizontal()),
            20.vs(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage()));
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
            )
          ],
        ),
      ),
    );
  }
}