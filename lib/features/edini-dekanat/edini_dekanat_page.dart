import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/config/extension.dart';

class EdiniDekanatPage extends StatelessWidget {
  const EdiniDekanatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Заказ справок"),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(Config.webWiewUrlSpravki.conf()),
        ),
        initialSettings: InAppWebViewSettings(
          useShouldOverrideUrlLoading: true,
          userAgent:
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
              "AppleWebKit/537.36 (KHTML, like Gecko) "
              "Chrome/129.0.6668.70 Safari/537.36",
          javaScriptEnabled: true,
          transparentBackground: true,
          verticalScrollBarEnabled: false,
          horizontalScrollBarEnabled: false,
        ),

        // onWebViewCreated: (controller) => webViewController = controller,
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
                justify-content: center;
                padding-bottom: 90px !important;
              }
              .SurveyPage-Button {
                --g-button-background-color: #4964BE !important;
                --g-button-background-color-hover: #4964BE !important;
                color: white !important;
              }
              .SurveyPage {
                padding: 0 !important;
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
        },
      ),
    );
  }
}
