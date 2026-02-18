import 'package:equatable/equatable.dart';

class FloorMapState with EquatableMixin {
  final int floor;
  final bool isNavigationRoomChange;

  FloorMapState({required this.floor, this.isNavigationRoomChange = false});

  @override
  List<Object?> get props => [floor];
}