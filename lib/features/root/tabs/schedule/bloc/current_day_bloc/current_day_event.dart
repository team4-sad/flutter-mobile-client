part of 'current_day_bloc.dart';

sealed class CurrentDayEvent extends Equatable {
  const CurrentDayEvent();

  @override
  List<Object> get props => [];
}

class SelectDayEvent extends CurrentDayEvent {
  final DateTime selectedDateTime;

  const SelectDayEvent({required this.selectedDateTime});

  @override
  List<Object> get props => [selectedDateTime];
}
