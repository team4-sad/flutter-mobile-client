import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/search_field_widget.dart';
import 'package:miigaik/features/root/tabs/map/bloc/floor_map_cubit/floor_map_cubit.dart';
import 'package:miigaik/features/root/tabs/map/bloc/map_cubit/map_cubit.dart';
import 'package:miigaik/features/root/tabs/map/bloc/search_map_cubit/search_map_cubit.dart';
import 'package:miigaik/features/root/tabs/map/models/room_model.dart';
import 'package:miigaik/features/root/tabs/map/widgets/category_hint.dart';
import 'package:miigaik/features/root/tabs/map/widgets/floor_widget.dart';
import 'package:miigaik/features/root/tabs/map/wrappers/map_wrapper.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/values.dart';

import 'models/category_model.dart';


class MapPage extends StatefulWidget {

  const MapPage({super.key});

  static const _baseUrl = "https://map.miigaik.ru/";

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  MapWrapper? _wrapper;
  final searchController = TextEditingController();
  final searchTextFocusNode = FocusNode();

  final searchMapCubit = SearchMapCubit();
  final cubit = GetIt.I.get<MapCubit>();
  final floorMapCubit = GetIt.I.get<FloorMapCubit>();

  bool isFullLoad = true;

  String _getInitialUrl([RoomModel? room]) {
    // Координаты центра карты и уровень масштабирования по умолчанию, чтобы
    // не показывать плавную анимацию приближения к кампусу МИИГАиК от
    // общего вида Москвы
    return "${MapPage._baseUrl}#map=16.89/55.763838/37.662047/68.4/42";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      bloc: cubit,
      listener: (context, state) async {
        if (state.searchRoom != null) {
          await _wrapper?.navigateToRoom(state.searchRoom!);
          floorMapCubit.change(state.searchRoom!.floor);
        }
      },
      child: BlocListener<FloorMapCubit, int>(
        bloc: floorMapCubit,
        listener: (context, state) async {
          await _wrapper?.changeFloor(state);
        },
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(_getInitialUrl(cubit.state.searchRoom))
                ),
                onLoadStart: (controller, url) async {
                  _wrapper = MapWrapper(controller: controller);
                  await _wrapper!.injectFix();
                },
                onLoadStop: (controller, url) async {
                  if (_wrapper == null) {
                    return;
                  }
                  if (cubit.state.categories == null ||
                      cubit.state.categories!.isEmpty) {
                    final categories = await _wrapper!.fetchCategoriesRooms();
                    cubit.setRooms(categories);
                  }
                  if ((await controller.getProgress() == 100) && !isFullLoad) {
                    isFullLoad = true;
                    if (cubit.state.searchRoom != null) {
                      await _wrapper!.navigateToRoom(cubit.state.searchRoom!);
                      floorMapCubit.change(cubit.state.searchRoom!.floor);
                    }
                  }
                }
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: paddingTopPage + 68,
                    right: 20
                  ),
                  child: FloorWidget(floorCount: 7)
                ),
              ),
              BlocBuilder<SearchMapCubit, SearchMapState>(
                bloc: searchMapCubit,
                builder: (context, state) {
                  final List<CategoryModel> hints;
                  if (searchController.text.isEmpty) {
                    hints = [];
                  } else {
                    hints = searchMapCubit.search(
                      cubit.state.categories ?? []
                    );
                  }
                  return Stack(
                    children: [
                      if (searchTextFocusNode.hasFocus)
                        GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              searchTextFocusNode.unfocus();
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black.withAlpha(64),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: paddingTopPage,
                          left: 20,
                          right: 20
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SearchFieldWidget(
                              focusNode: searchTextFocusNode,
                              hint: "Поиск и выбор мест",
                              unFocusOnTapOutside: false,
                              onChangeFocusSearchField: (_) {
                                setState(() {});
                              },
                              enableClear: true,
                              textEditingController: searchController,
                              onChangeText: (value) {
                                searchMapCubit.setSearchText(value);
                              },
                              onTapClear: () {
                                searchMapCubit.setSearchText("");
                              },
                            ),
                            10.vs(),
                            if (searchTextFocusNode.hasFocus)
                              BlocBuilder<SearchMapCubit, SearchMapState>(
                                bloc: searchMapCubit,
                                builder: (context, state) {
                                  if (hints.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 340
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: context.palette.container,
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: ListView.separated(
                                        padding: EdgeInsetsGeometry.symmetric(
                                          vertical: 20,
                                        ),
                                        separatorBuilder: (_, __) => 20.vs(),
                                        itemBuilder: (context, index) {
                                          return CategoryHint(
                                            category: hints[index],
                                            onTap: (room) async {
                                              cubit.setSearchRoom(room);
                                              searchTextFocusNode.unfocus();
                                              searchController.text =
                                                  room.label;
                                            }
                                          );
                                        },
                                        itemCount: hints.length,
                                        shrinkWrap: true,
                                      ),
                                    ),
                                  );
                                },
                              )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
              if (!isFullLoad)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: context.palette.background,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}