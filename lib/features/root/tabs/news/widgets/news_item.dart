import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      decoration: BoxDecoration(
        color: context.palette.container,
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "https://www.miigaik.ru/upload/iblock/de2/xnkgdh2140swp45nojmanzlsukgamcm1.jpg",
                  height: 135.h,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
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
                        "22.09.2025",
                        style: TS.regular10.use(context.palette.text)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          10.vs(),
          Text(
            "Студенты МИИГАиК на фестивале \"Открытый город\"",
            style: TS.medium15.use(context.palette.text),
          ),
          5.vs(),
          Text(
            "В рамках фестиваля \"Открытый город\" группа градостроителей 5 курса Факультета архитекту"
            " В рамках фестиваля \"Открытый город\" группа градостроителей 5 курса Факультета архитекту "
            "В рамках фестиваля \"Открытый город\" группа градостроителей 5 курса Факультета архитекту ",
            style: TS.light12.use(context.palette.text),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}