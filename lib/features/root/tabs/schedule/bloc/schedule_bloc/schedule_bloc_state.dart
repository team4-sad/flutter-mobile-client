part of 'schedule_bloc_bloc.dart';

sealed class ScheduleState {
  const ScheduleState();
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleError extends WithErrorState implements ScheduleState {
  final SignatureScheduleModel signature;
  final DateTime date;

  ScheduleError({
    required super.error,
    required this.date,
    required this.signature,
  });
}

final class ScheduleLoaded extends ScheduleState {
  final DayScheduleModel? daySchedule;
  final SignatureScheduleModel signature;
  final DateTime date;

  const ScheduleLoaded({
    required this.daySchedule,
    required this.signature,
    required this.date,
  });
}
