import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
part 'current_day_event.dart';
part 'current_day_state.dart';

class CurrentDayBloc extends Bloc<CurrentDayEvent, CurrentDayState> {
  CurrentDayBloc() : super(CurrentDayState(currentDateTime: DateTime.now())) {
    on<SelectDayEvent>((event, emit) {
      emit(CurrentDayState(currentDateTime: event.selectedDateTime));
    });
  }
}
