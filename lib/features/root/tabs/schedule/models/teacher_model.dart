import 'dart:convert';

class TeacherModel {
  final String firstName;
  final String lastName;
  final String patronymic;
  TeacherModel({
    required this.firstName,
    required this.lastName,
    required this.patronymic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'patronymic': patronymic,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      patronymic: map['patronymic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String get displayName => "$lastName ${firstName[0]}.${patronymic[0]}.";
}
