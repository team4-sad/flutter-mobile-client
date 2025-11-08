import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class EdiniDekanatPage extends StatefulWidget {
  final String title;
  final String url;

  const EdiniDekanatPage._({super.key, required this.title, required this.url});

  EdiniDekanatPage.spravki({key})
    : this._(
        key: key,
        title: "Заказ справок",
        url: Config.webWiewUrlSpravki.conf(),
      );

  EdiniDekanatPage.dopuski({key})
    : this._(
        key: key,
        title: "Заказ допуска",
        url: Config.webWiewUrlDopuski.conf(),
      );

  @override
  State<EdiniDekanatPage> createState() => _EdiniDekanatPageState();
}

class _EdiniDekanatPageState extends State<EdiniDekanatPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.title),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialSettings: InAppWebViewSettings(
              useShouldOverrideUrlLoading: true,
              userAgent: Config.webWiewUserAgent.conf(),
              javaScriptEnabled: true,
              transparentBackground: true,
              verticalScrollBarEnabled: false,
              horizontalScrollBarEnabled: false,
            ),
            onLoadStop: (controller, url) async {
              await controller.evaluateJavascript(
                source: """
                  (function() {
                    const style = document.createElement('style');
                    style.innerHTML = `
                      .Layout {
                        flex-direction: column;
                        align-items: center;
                        min-height: 100vh;
                        display: flex;
                        position: relative;
                      }
                      .SurveyPage-Button {
                        --g-button-background-color: #4964BE !important;
                        --g-button-background-color-hover: #4964BE !important;
                        color: white !important;
                        margin: 0 !important
                      }
                      .SurveyPage {
                        padding-top: 20px !important;
                      }
                      .SurveyPage-Content {
                        padding: 0 !important;
                        padding-left: 36px !important;
                        padding-right: 36px !important;
                      }
                      .g-card {
                        box-shadow: none !important;
                      }
                      header, footer, h1.g-color-text.g-text.g-text_variant_display-3.MarkdownText.SurveyPage-Name {
                        display: none !important;
                      }
                    `;
                    document.head.appendChild(style);
            
                    // Для динамически создаваемых элементов
                    const mo = new MutationObserver(() => {});
                    mo.observe(document.body, { childList: true, subtree: true });
                  })();
                """,
              );
              // При вызове указанной выше JS функции содержимое формы 
              // появляется снизу и мгновенно перемещается наверх. 
              // Задержка нужна чтобы пользователь этого не видел 
              Future.delayed(Duration(milliseconds: 100)).then((_) {
                setState(() {
                  isLoading = false;
                });
              });
            },
          ),
          if (isLoading)
            Container(
              width: 1.sw,
              height: 1.sh,
              color: context.palette.background,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
