import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miigaik/features/edini-dekanat/js_injector.dart';

class MapInAppWebViewJsInjector extends IJsInjector {
  final InAppWebViewController controller;

  MapInAppWebViewJsInjector(this.controller);

  @override
  Future<void> inject() async {
    await controller.evaluateJavascript(source: """
      (function() {
        var style = document.createElement('style');
        style.type = 'text/css';
        style.innerHTML = `
          /* Скрываем нижние панели Mapbox */
          .mapboxgl-ctrl-bottom-left,
          .mapboxgl-ctrl-bottom-right {
            display: none !important;
          }
          
          /* Растягиваем блок поиска и настроек на всю ширину */
          .map-overlay-inner {
            margin-top: 48px !important;    /* отступ сверху */
            left: 10px !important;           /* отступ слева */
            right: 10px !important;          /* отступ справа */
            width: auto !important;           /* ширина автоматически */
          }
          
          /* 3. Растягиваем поле поиска на всю ширину с учётом кнопки очистки */
          #search {
            width: 100% !important;
            box-sizing: border-box !important;
            padding-right: 30px !important; /* место для крестика */
          }
        `;
        document.head.appendChild(style);
      })();
    """);
  }
}