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
      'first_name': firstName,
      'last_name': lastName,
      'patronymic': patronymic,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      patronymic: map['patronymic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String get displayName => "$lastName ${firstName[0]}.${patronymic[0]}.";

  String get fio => "$lastName $firstName $patronymic";
}
