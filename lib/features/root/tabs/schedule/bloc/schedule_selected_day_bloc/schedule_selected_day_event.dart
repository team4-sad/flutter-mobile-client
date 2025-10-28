part of 'schedule_selected_day_bloc.dart';

sealed class ScheduleSelectedDayEvent extends Equatable {
  const ScheduleSelectedDayEvent();

  @override
  List<Object> get props => [];
}

class SelectDayEvent extends ScheduleSelectedDayEvent {
  final DateTime selectedDateTime;

  const SelectDayEvent({required this.selectedDateTime});

  @override
  List<Object> get props => [selectedDateTime];
}
