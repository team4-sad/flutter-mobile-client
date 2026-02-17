part of 'map_cubit.dart';

class MapState with EquatableMixin {
  final RoomModel? searchRoom;
  final List<CategoryModel>? categories;
  final InAppWebViewController? controller;

  MapState({this.searchRoom, this.categories, this.controller});

  MapState copyWith({
    RoomModel? searchRoom,
    List<CategoryModel>? categories,
    InAppWebViewController? controller
  }) {
    return MapState(
      searchRoom: searchRoom ?? this.searchRoom,
      categories: categories ?? this.categories,
      controller: controller ?? this.controller,
    );
  }

  @override
  List<Object?> get props => [searchRoom, categories, controller];
}
