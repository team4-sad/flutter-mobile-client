class NewsPaginationModel {
  final int currentPage;
  final bool hasNext;

  NewsPaginationModel({
    required this.currentPage,
    required this.hasNext
  });

  factory NewsPaginationModel.fromJson(Map<String, dynamic> json) =>
    NewsPaginationModel(
      currentPage: json["current_page"]!,
      hasNext: json["has_next"]!
    );
}