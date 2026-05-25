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

class FilledDocumentFormField extends DocumentFormField {

  final String value;

  FilledDocumentFormField({
    required super.label,
    required super.type,
    required super.isRequired,
    required super.options,
    required this.value
  });

  Map<String, dynamic> toJson() => {
    "label": label,
    "type": type.name,
    "is_required": isRequired,
    "options": options,
    "value": value
  };

  FilledDocumentFormField copyWith({
    String? label,
    bool? isRequired,
    List<String>? options,
    String? value,
    DocumentFieldType? type
  }) => FilledDocumentFormField(
    label: label ?? this.label,
    type: type ?? this.type,
    isRequired: isRequired ?? this.isRequired,
    options: options ?? this.options,
    value: value ?? this.value
  );
}