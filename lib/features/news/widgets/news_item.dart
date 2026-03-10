import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';
import 'package:miigaik/features/news/models/news_model.dart';
import 'package:miigaik/generated/types.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsItemWidget extends StatelessWidget {

  final NewsModel _newsModel;
  final VoidCallback? _onTap;

  final bool showDescription;
  final int? maxLinesTitle;

  const NewsItemWidget({
    super.key,
    required NewsModel newsModel,
    void Function()? onTap,
    this.showDescription = true,
    this.maxLinesTitle
  }) : _onTap = onTap, _newsModel = newsModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: (_newsModel.hasImage) ? 30 : 15
        ),
        decoration: BoxDecoration(
          color: context.palette.container,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_newsModel.hasImage)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: _newsModel.imageLink!,
                        height: 135.h,
                        width: 1.sw,
                        fit: BoxFit.cover,
                        placeholder: (context, _) => AppShimmer.image(width: 1.sw),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.palette.container
                            ),
                            child: Text(
                              _newsModel.date,
                              style: TS.regular8.use(context.palette.text)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            Text(
              _newsModel.title,
              overflow: (maxLinesTitle != null) ? TextOverflow.ellipsis : null,
              maxLines: maxLinesTitle,
              style: TS.medium13.use(context.palette.text),
            ),
            if (showDescription)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  _newsModel.description ?? S.no_news_description.tr(),
                  style: TS.light10.use(context.palette.text),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (!_newsModel.hasImage)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _newsModel.date,
                    style: TS.medium10.use(context.palette.text)
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}