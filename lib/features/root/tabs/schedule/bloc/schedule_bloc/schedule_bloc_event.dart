part of 'schedule_bloc.dart';

sealed class ScheduleBlocEvent extends Equatable {
  const ScheduleBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchScheduleEvent extends ScheduleBlocEvent {
  final DateTime day;
  final SignatureScheduleModel signature;

  const FetchScheduleEvent({required this.day, required this.signature});

  @override
  List<Object> get props => [day, signature];
}
