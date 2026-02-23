import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miigaik/features/root/tabs/map/bloc/floor_map_cubit/floor_map_state.dart';

class FloorMapCubit extends Cubit<FloorMapState> {
  FloorMapCubit() : super(FloorMapState(floor: 1));

  void change(FloorMapState floor) {
    emit(floor);
  }
}
