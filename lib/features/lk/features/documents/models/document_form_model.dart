import 'package:miigaik/features/lk/features/documents/models/document_form_field.dart';
import 'package:miigaik/features/lk/features/documents/models/interval_model.dart';

class DocumentFormModel {
  final String name;
  final String description;
  final IntervalModel intervalMake;
  final List<DocumentFormField> fields;

  DocumentFormModel({
    required this.name,
    required this.description,
    required this.intervalMake,
    required this.fields
  });

  factory DocumentFormModel.fromJson(Map<String, dynamic> json) => DocumentFormModel(
    name: json['name'],
    description: json['description'],
    intervalMake: IntervalModel.fromJson(json["interval_make"]),
    fields: (json["fields"] as List).map((e) => DocumentFormField.fromJson(e)).toList(),
  );
}