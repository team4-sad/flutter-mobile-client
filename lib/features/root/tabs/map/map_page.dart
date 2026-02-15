import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miigaik/features/root/tabs/map/js_injector.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  InAppWebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("https://map.miigaik.ru/")
        ),
        onLoadStop: (controller, url) async {
          _controller = controller;
          await MapInAppWebViewJsInjector(
            controller,
          ).inject();
        },
      ),
    );
  }
}