enum SignatureScheduleType {
  group(display: "Группа"),
  audience(display: "Аудитория"),
  teacher(display: "Преподаватель");

  final String display;

  const SignatureScheduleType({required this.display});
}