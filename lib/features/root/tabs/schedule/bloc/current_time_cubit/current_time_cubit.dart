import 'package:datetime_loop/datetime_loop.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_time_state.dart';

class CurrentTimeCubit extends Cubit<CurrentTimeState> {
  final controller = DateTimeLoopController(timeUnit: TimeUnit.minutes);

  CurrentTimeCubit() : super(CurrentTimeState(DateTime.now())) {
    controller.dateTimeStream.listen((dateTime) {
      emit(CurrentTimeState(dateTime));
    });
  }
}
