import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class FloorMapCubit extends Cubit<int> {
  FloorMapCubit() : super(1);

  void change(int floor) {
    emit(floor);
  }
}
