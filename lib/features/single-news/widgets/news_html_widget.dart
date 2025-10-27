import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:miigaik/features/common/widgets/image_dialog.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHtmlWidget extends StatelessWidget {
  final String html;

  const NewsHtmlWidget({super.key, required this.html});

  static final _ignoreDomains = <String>[];

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      enableCaching: !kDebugMode,
      baseUrl: Uri.parse(Config.baseImageUrl.conf()),
      renderMode: RenderMode.sliverList,
      customStylesBuilder: (element) {
        if (element.className == "news-item-image") {
          return {"margin-bottom": "10px"};
        }
        if (element.localName == "hr") {
          return {"display": "none"};
        }
        if (element.localName == "img") {
          return {"border-radius": "15px"};
        }
        if (element.localName == "iframe") {
          final attrs = element.attributes;
          if (attrs.containsKey("src")) {
            final fullUrl = attrs["src"]!.toString();
            final domain = _getDomain(fullUrl);
            _ignoreDomains.add(domain);
          }
        }
        return null;
      },
      textStyle: TS.light15,
      onTapImage: (metadata) async {
        final image = metadata.sources.firstOrNull;
        if (image != null) {
          showNetworkImageDialog(context, image.url);
        }
      },
      onTapUrl: (rawUrl) async {
        final domain = _getDomain(rawUrl);
        if (_ignoreDomains.contains(domain)) {
          return true;
        }
        final Uri url = Uri.parse(rawUrl);
        return !await launchUrl(url);
      },
      onLoadingBuilder: (context, element, progress) {
        return SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  String _getDomain(String url) => Uri.parse(url).host;
}
