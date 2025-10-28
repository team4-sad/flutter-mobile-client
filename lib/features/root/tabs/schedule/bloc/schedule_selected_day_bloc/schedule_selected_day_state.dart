part of 'schedule_selected_day_bloc.dart';

class ScheduleSelectedDayState extends Equatable {
  final DateTime currentDateTime;

  DateTime get currentOnlyDate => currentDateTime.onlyDate();

  const ScheduleSelectedDayState({required this.currentDateTime});

  @override
  List<Object> get props => [currentDateTime];
}
