part of 'map_cubit.dart';

class MapState with EquatableMixin {
  final RoomModel? searchRoom;
  final List<CategoryModel>? categories;

  MapState({this.searchRoom, this.categories});

  MapState copyWith({
    RoomModel? searchRoom,
    List<CategoryModel>? categories,
  }) {
    return MapState(
      searchRoom: searchRoom ?? this.searchRoom,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [searchRoom, categories];
}
