import 'package:miigaik/features/lk/features/documents/enum/document_field_type.dart';

class DocumentFormField {
  final String label;
  final DocumentFieldType type;
  final bool isRequired;
  final List<String> options;

  DocumentFormField({
    required this.label,
    required this.type,
    required this.isRequired,
    required this.options
  });

  factory DocumentFormField.fromJson(Map<String, dynamic> json) => DocumentFormField(
    label: json["label"],
    type: DocumentFieldType.fromString(json["type"]),
    isRequired: json["is_required"],
    options: json["options"]
  );
}