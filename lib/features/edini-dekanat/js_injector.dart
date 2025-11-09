import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract class IJsInjector {
  Future<void> inject();
}

class YandexFormInAppWebViewJsInjector extends IJsInjector {
  final InAppWebViewController controller;

  YandexFormInAppWebViewJsInjector({required this.controller});

  @override
  Future<void> inject() async {
    await controller.evaluateJavascript(
      source: """
        (function() {
          // Добавляем шрифт Roboto
          const fontStyle = document.createElement('style');
          fontStyle.innerHTML = `
            @font-face {
              font-family: 'Roboto';
              src: local('Roboto'),
                    url('flutter_assets/assets/fonts/Roboto-Regular.ttf') format('truetype');
              font-weight: normal;
              font-style: normal;
            }
          `;
          document.head.appendChild(fontStyle);

          const style = document.createElement('style');
          style.innerHTML = `
            .Layout {
              flex-direction: column;
              align-items: center;
              min-height: 100vh;
              display: flex;
              position: relative;
            }
            .SuccessMessage-Wrapper {
              padding: 0 !important;
            }
            .SuccessMessage {
              border: 0 !important;
            }
            .SuccessPage {
              padding: 0 !important;
              padding-left: 12px !important;
              padding-right: 12px !important;
            }
            .SurveyPage-Button {
              --g-button-background-color: #4964BE !important;
              --g-button-background-color-hover: #4964BE !important;
              color: white !important;
              margin: 0 !important
            }
            p {
              font-family: 'Roboto', sans-serif;
              font-size: 15px;
            }
            .SurveyPage {
              padding-top: 20px !important;
            }
            .SurveyPage-Content {
              padding: 0 !important;
              padding-left: 12px !important;
              padding-right: 12px !important;
            }
            .g-card {
              box-shadow: none !important;
            }
            header, footer, .Promo, .Share, .SuccessMessage-Buttons, .TopLineAdv, h1.g-color-text.g-text.g-text_variant_display-3.MarkdownText.SurveyPage-Name {
              display: none !important;
            }
          `;
          document.head.appendChild(style);
  
          const mo = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
              mutation.addedNodes.forEach((node) => {
                if (node.nodeType === 1) { // ELEMENT_NODE
                  const paragraphs = node.querySelectorAll ? node.querySelectorAll('p') : [];
                  paragraphs.forEach(p => {
                    p.style.fontFamily = 'Roboto, sans-serif';
                    p.style.fontSize = '15px';
                  });
                }
              });
            });
          });
          mo.observe(document.body, { childList: true, subtree: true });
        })();
      """,
    );
  }
}
