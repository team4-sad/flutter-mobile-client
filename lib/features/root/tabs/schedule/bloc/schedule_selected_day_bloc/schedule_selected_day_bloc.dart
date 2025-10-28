import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
part 'schedule_selected_day_event.dart';
part 'schedule_selected_day_state.dart';

class ScheduleSelectedDayBloc
    extends Bloc<ScheduleSelectedDayEvent, ScheduleSelectedDayState> {
  ScheduleSelectedDayBloc()
    : super(ScheduleSelectedDayState(currentDateTime: DateTime.now())) {
    on<SelectDayEvent>((event, emit) {
      emit(ScheduleSelectedDayState(currentDateTime: event.selectedDateTime));
    });
  }
}
