part of 'current_time_cubit.dart';

class CurrentTimeState extends Equatable {
  final DateTime currentDateTime;

  const CurrentTimeState(this.currentDateTime);

  @override
  List<Object> get props => [currentDateTime];
}
