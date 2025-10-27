part of 'current_day_bloc.dart';

class CurrentDayState extends Equatable {
  final DateTime currentDateTime;

  DateTime get currentOnlyDate => DateTime(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day,
  );

  const CurrentDayState({required this.currentDateTime});

  @override
  List<Object> get props => [currentDateTime];
}
