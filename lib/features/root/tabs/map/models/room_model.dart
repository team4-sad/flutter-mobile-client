import 'package:equatable/equatable.dart';

class RoomModel with EquatableMixin{
  final String label;
  final int id;

  RoomModel({required this.label, required this.id});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      label: json['label'] as String,
      id: json['id'] as int,
    );
  }

  @override
  List<Object?> get props => [label, id];
}