enum OrderDocumentStatus {
  unknown(name: "unknown", display: "Неизвестно"),
  complete(name: "complete", display: "Готово"),
  inProgress(name: "in_progress", display: "В работе"),
  reject(name: "reject", display: "Отклонено");

  final String name;
  final String display;

  const OrderDocumentStatus({required this.name, required this.display});

  factory OrderDocumentStatus.fromString(String name) => values.firstWhere(
    (e) => e.name == name,
    orElse: () => OrderDocumentStatus.unknown
  );
}