enum DocumentFieldType {
  unknown(name: "unknown"),
  select(name: "select"),
  singleLine(name: "single_line"),
  educationProgram(name: "education_program"),
  datePicker(name: "date_picker");

  final String name;

  const DocumentFieldType({required this.name});

  factory DocumentFieldType.fromString(String name) => values.firstWhere(
    (e) => e.name == name,
    orElse: () => DocumentFieldType.unknown
  );
}