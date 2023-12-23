class Blog {
  String id;
  String title;
  String content;
  DateTime publishedAt;
  bool isLikedByMe = false;
  String headerImageUrl;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.headerImageUrl,
  });

  String get publishedDateString =>
      "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";

  factory Blog.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        '\$id': String id,
        'title': String title,
        'content': String content,
        '\$createdAt': String publishedAt,
        'headerImageUrl': String? headerImageUrl,
      } =>
          Blog(
            id: id,
            title: title,
            content: content,
            publishedAt: DateTime.parse(publishedAt),
            headerImageUrl: headerImageUrl ?? "https://picsum.photos/100",
          ),
      _ => throw const FormatException("Unexpected JSON structure", ),
    };
  }
}