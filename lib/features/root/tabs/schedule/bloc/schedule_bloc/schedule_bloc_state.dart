part of 'schedule_bloc_bloc.dart';

sealed class ScheduleState {
  const ScheduleState();
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleError extends WithErrorState implements ScheduleState {
  final String groupId;
  final DateTime date;

  ScheduleError({required super.error, required this.date, required this.groupId});
}

final class ScheduleLoaded extends ScheduleState {
  final DayScheduleModel? daySchedule;
  final String groupId;
  final DateTime date;

  const ScheduleLoaded({required this.daySchedule, required this.groupId, required this.date});
}
