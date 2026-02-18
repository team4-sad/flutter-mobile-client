import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/root/tabs/map/models/category_model.dart';
import 'package:miigaik/features/root/tabs/map/models/room_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  void setSearchRoom(RoomModel searchRoom) async {
    emit(state.copyWith(searchRoom: searchRoom));
  }

  void setRooms(List<CategoryModel> rooms) {
    emit(state.copyWith(categories: rooms));
  }
}
