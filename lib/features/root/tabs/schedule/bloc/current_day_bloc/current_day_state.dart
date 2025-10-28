part of 'current_day_bloc.dart';

class CurrentDayState extends Equatable {
  final DateTime currentDateTime;

  DateTime get currentOnlyDate => currentDateTime.onlyDate();

  const CurrentDayState({required this.currentDateTime});

  @override
  List<Object> get props => [currentDateTime];
}
