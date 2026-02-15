import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:miigaik/features/common/widgets/image_dialog.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHtmlWidget extends StatelessWidget {
  final String html;

  const NewsHtmlWidget({super.key, required this.html});

  static final _ignoreDomains = <String>[];

  void _onTapImage(BuildContext context, String? url) async {
    if (url != null) {
      showNetworkImageDialog(context, url);
    }
  }

  Future<bool> _onTapUrl(String rawUrl) async {
    final domain = _getDomain(rawUrl);
    if (_ignoreDomains.contains(domain)) {
      return true;
    }
    final Uri url = Uri.parse(rawUrl);
    return !await launchUrl(url);
  }

  Widget _onLoadingBuilder(_, __, ___) {
    return SizedBox(
      height: 100,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      enableCaching: !kDebugMode,
      baseUrl: Uri.parse(Config.baseImageUrl),
      renderMode: RenderMode.sliverList,
      customStylesBuilder: (element) {
        if (element.className == "news-item-image") {
          return {"margin-bottom": "10px"};
        }
        if (element.localName == "hr") {
          return {"display": "none"};
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
      customWidgetBuilder: (element) {
        final baseUrl = Config.baseImageUrl;
        if (element.localName == 'img') {
          final src = element.attributes['src'];
          if (src != null) {
            final url = "$baseUrl/$src";
            return GestureDetector(
              onTap: () => _onTapImage(context, url),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _onLoadingBuilder(context, element, null),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            );
          }
        }
        return null;
      },
      textStyle: TS.light15,
      onTapUrl: _onTapUrl,
      onLoadingBuilder: _onLoadingBuilder,
    );
  }

  String _getDomain(String url) => Uri.parse(url).host;
}
