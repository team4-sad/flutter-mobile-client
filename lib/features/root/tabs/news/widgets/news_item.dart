import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';
import 'package:miigaik/features/root/tabs/news/models/news_model.dart';
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsItemWidget extends StatelessWidget {

  final NewsModel newsModel;

  const NewsItemWidget({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: (newsModel.hasImage) ? 30 : 15
      ),
      decoration: BoxDecoration(
        color: context.palette.container,
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (newsModel.hasImage)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: newsModel.imageLink!,
                      height: 135.h,
                      width: 1.sw,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, _) =>
                          AppShimmer(width: 1.sw, height: 135.h),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: context.palette.container
                          ),
                          child: Text(
                            newsModel.date,
                            style: TS.regular10.use(context.palette.text)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          Text(
            newsModel.title,
            style: TS.medium15.use(context.palette.text),
          ),
          5.vs(),
          Text(
            newsModel.description ?? S.no_news_description.tr(),
            style: TS.light12.use(context.palette.text),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (!newsModel.hasImage)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  newsModel.date,
                  style: TS.medium12.use(context.palette.text)
                ),
              ),
            )
        ],
      ),
    );
  }
}