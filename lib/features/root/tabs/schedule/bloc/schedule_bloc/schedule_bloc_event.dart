part of 'schedule_bloc.dart';

sealed class ScheduleBlocEvent extends Equatable {
  const ScheduleBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchScheduleEvent extends ScheduleBlocEvent {
  final DateTime day;
  final SignatureScheduleModel signature;
  final bool ignoreCache;

  const FetchScheduleEvent({
    required this.day,
    required this.signature,
    this.ignoreCache = false
  });

  @override
  List<Object> get props => [day, signature, ignoreCache];
}
