import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemService extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? url;
  final VoidCallback? onTap;

  const ItemService({
    super.key,
    required this.title,
    required this.subTitle,
    this.url, this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (onTap != null){
          onTap!();
        }
        if (url != null){
          launchUrl(Uri.parse(url!));
        }
      },
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: context.palette.container,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TS.medium15.use(context.palette.text)),
            3.vs(),
            Text(subTitle, style: TS.regular12.use(context.palette.subText)),
          ],
        ),
      ),
    );
  }
}