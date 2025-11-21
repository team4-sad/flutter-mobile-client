import 'package:hive/hive.dart';

part 'signature_schedule_type.g.dart';

@HiveType(typeId: 1)
enum SignatureScheduleType {
  @HiveField(0)
  group(display: "Группа"),

  @HiveField(1)
  audience(display: "Аудитория"),

  @HiveField(2)
  teacher(display: "Преподаватель");

  final String display;

  const SignatureScheduleType({required this.display});

  factory SignatureScheduleType.fromDisplay(String display) =>
      SignatureScheduleType.values.where((e) => e.display == display).first;
}