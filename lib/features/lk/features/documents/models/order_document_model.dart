import 'package:miigaik/features/lk/features/documents/enum/order_document_status.dart';
import 'package:miigaik/features/lk/features/documents/models/interval_model.dart';

class OrderDocumentModel {
  final int id;
  final String number;
  final String name;
  final DateTime createdAt;
  final IntervalModel intervalModel;
  final OrderDocumentStatus status;
  final String? comment;

  OrderDocumentModel({
    required this.id,
    required this.number,
    required this.name,
    required this.createdAt,
    required this.intervalModel,
    required this.status,
    required this.comment
  });

  factory OrderDocumentModel.fromJson(Map<String, dynamic> json) => OrderDocumentModel(
    id: json["id"],
    number: json["number"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    intervalModel: IntervalModel.fromJson(json["interval"]),
    status: OrderDocumentStatus.fromString(json["status"]),
    comment: json["comment"]
  );
}