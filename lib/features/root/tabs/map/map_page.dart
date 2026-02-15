import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/map/bloc/map_cubit.dart';
import 'package:miigaik/features/root/tabs/map/js_injector.dart';

class MapPage extends StatefulWidget {

  final int? roomId;

  const MapPage({super.key, this.roomId});

  static const _baseUrl = "https://map.miigaik.ru/";

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final cubit = GetIt.I.get<MapCubit>();
  late final InAppWebViewController controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.roomId != null) {
          _searchRoomById(state.roomId!);
        }
      },
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(_getInitialUrl(cubit.state.roomId))
          ),
          onLoadStart: (controller, url){
            this.controller = controller;
          },
          onLoadStop: (controller, url) async {
            await MapInAppWebViewJsInjector(
              controller,
            ).inject();
          },
        ),
      ),
    );
  }

  String _getInitialUrl([int? roomId]) {
    if (roomId != null) {
      return "${MapPage._baseUrl}#room=$roomId";
    }
    // Координаты центра карты и уровень масштабирования по умолчанию, чтобы
    // не показывать плавную анимацию приближения к кампусу МИИГАиК от
    // общего вида Москвы
    return "${MapPage._baseUrl}#map=16.89/55.763838/37.662047/68.4/42&l=2";
  }

  Future<void> _searchRoomById(int id) async {
    final jsCode = "window.location.hash = '#id=$id';";
    await controller.evaluateJavascript(source: jsCode);
  }
}