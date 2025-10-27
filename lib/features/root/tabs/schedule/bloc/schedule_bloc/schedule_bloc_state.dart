part of 'schedule_bloc_bloc.dart';

sealed class ScheduleState {
  const ScheduleState();
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleError extends WithErrorState implements ScheduleState {
  ScheduleError({required super.error});
}

final class ScheduleLoaded extends ScheduleState {
  final List<LessonModel> lessons;
  final String groupId;
  final DateTime date;

  const ScheduleLoaded({required this.lessons, required this.groupId, required this.date});
}
