part of 'schedule_bloc_bloc.dart';

sealed class ScheduleBlocEvent extends Equatable {
  const ScheduleBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchScheduleEvent extends ScheduleBlocEvent {
  final DateTime day;
  final String groupId;

  const FetchScheduleEvent({required this.day, required this.groupId});

  @override
  List<Object> get props => [day, groupId];
}
