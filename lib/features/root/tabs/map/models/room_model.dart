import 'package:equatable/equatable.dart';

class RoomModel with EquatableMixin{
  final String label;
  final int id;
  final int floor;

  RoomModel({required this.label, required this.id, required this.floor});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      label: json['label'] as String,
      id: json['id'] as int,
      floor: json['floor'] as int,
    );
  }

  @override
  List<Object?> get props => [label, id, floor];
}