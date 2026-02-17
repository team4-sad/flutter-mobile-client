import 'package:equatable/equatable.dart';
import 'package:miigaik/features/root/tabs/map/models/room_model.dart';

class CategoryModel with EquatableMixin {
  final String name;
  final List<RoomModel> rooms;

  CategoryModel({required this.name, required this.rooms});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] as String,
      rooms: (json['rooms'] as List<dynamic>)
          .map((roomJson) => RoomModel.fromJson(roomJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [name, rooms];
}