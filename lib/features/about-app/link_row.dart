import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkRow extends StatelessWidget {

  final Widget? icon;
  final String link;
  final EdgeInsets? padding;
  final bool isCanOpenLink;

  const LinkRow({super.key, this.icon, required this.link, this.padding, this.isCanOpenLink = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (isCanOpenLink){
          launchUrl(Uri.parse(link));
        }
      },
      child: Padding(
        padding: padding ?? EdgeInsets.only(top: 30),
        child: Row(
          children: [
            if (icon != null)
              Padding(padding: EdgeInsets.only(right: 10), child: icon!),
            Text(link, style: TS.regular15.use(context.palette.text))
          ],
        ),
      ),
    );
  }
}