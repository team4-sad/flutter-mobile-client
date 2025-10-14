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
      hasNext: json["is_next_page"]!
    );
}