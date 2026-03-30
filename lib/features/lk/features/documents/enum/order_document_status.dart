enum OrderDocumentStatus {
  unknown(name: "unknown"),
  complete(name: "complete"),
  inProgress(name: "in_progress"),
  reject(name: "reject");

  final String name;

  const OrderDocumentStatus({required this.name});

  factory OrderDocumentStatus.fromString(String name) => values.firstWhere(
    (e) => e.name == name,
    orElse: () => OrderDocumentStatus.unknown
  );
}