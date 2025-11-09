import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/config/config.dart';
import 'package:miigaik/features/config/extension.dart';
import 'package:miigaik/features/edini-dekanat/js_injector.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/values.dart';

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
  bool isError = false;
  bool isErrorConnection = false;

  InAppWebViewController? _controller;
  final NetworkConnectionService _connectionService = GetIt.I.get();
  StreamSubscription? _subscription;

  void _reload() {
    _controller?.reload();
    setState(() {
      isLoading = true;
      isError = false;
      isErrorConnection = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isErrorConnection = !(_connectionService.lastStatus?.isConnect ?? true);
    isLoading = !isErrorConnection;
    _subscription = _connectionService.onConnectionChanged.listen(
      _onChangeNetworkStatus,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  void _onChangeNetworkStatus(status) {
    if (status.isConnect && isErrorConnection) {
      _reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.title),
      body: Stack(
        children: [
          if (!isError && !isErrorConnection)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                initialSettings: InAppWebViewSettings(
                  useShouldOverrideUrlLoading: true,
                  userAgent: Config.webWiewUserAgent.conf(),
                  javaScriptEnabled: true,
                  transparentBackground: true,
                  verticalScrollBarEnabled: false,
                  horizontalScrollBarEnabled: false,
                ),
                onReceivedError: (controller, request, error) {
                  _controller = controller;
                  setState(() {
                    isError = true;
                  });
                },
                onLoadStop: (controller, url) async {
                  _controller = controller;
                  await YandexFormInAppWebViewJsInjector(
                    palette: context.palette,
                    controller: controller,
                  ).inject();
                  // При вызове ииъекции JS функции содержимое формы
                  // появляется снизу и мгновенно перемещается наверх.
                  // Задержка нужна чтобы пользователь этого не видел.
                  Future.delayed(Duration(milliseconds: 100)).then((_) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                },
              ),
            ),
          if (isLoading)
            Container(
              width: 1.sw,
              height: 1.sh,
              color: context.palette.background,
              child: Center(child: CircularProgressIndicator()),
            ),
          if (isError)
            Center(
              child: PlaceholderWidget.somethingWentWrong(
                onButtonPress: _reload,
              ),
            ),
          if (isErrorConnection)
            Center(
              child: PlaceholderWidget.noConnection(onButtonPress: _reload),
            ),
        ],
      ),
    );
  }
}
