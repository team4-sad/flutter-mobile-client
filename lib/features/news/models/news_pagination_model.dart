class PaginationModel {
  final int currentPage;
  final bool hasNext;

  PaginationModel({
    required this.currentPage,
    required this.hasNext
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
    PaginationModel(
      currentPage: json["current_page"]!,
      // @TODO
      hasNext: json["is_next_page"] ?? json["has_next_page"]!
    );
}