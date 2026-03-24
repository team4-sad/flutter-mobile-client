class SingleNewsModel {
  final String title;
  final String htmlContent;
  final String date;

  SingleNewsModel({
    required this.title,
    required this.htmlContent,
    required this.date
  });

  factory SingleNewsModel.fromJson(Map<String, dynamic> json) =>
    SingleNewsModel(
      title: json["header"]!.toString(),
      htmlContent: json["content_html"]!.toString(),
      date: json["date_created"]!.toString()
    );
}