class NewsModel {
  final String id;
  final String title;
  final String? description;
  final String? imageLink;
  final String date;
  final String newsLink;

  const NewsModel({
    required this.id,
    required this.title,
    required this.date,
    required this.newsLink,
    this.imageLink,
    this.description,
  });

  bool get hasImage => imageLink?.isNotEmpty ?? false;
  bool get hasDescription => description?.isNotEmpty ?? false;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      newsLink: json['news_link']?.toString() ?? '',
      imageLink: json['image_link']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image_link': imageLink,
    'date': date,
    'news_link': newsLink,
  };
}
