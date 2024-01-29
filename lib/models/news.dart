class News {
  const News({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  final String id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String urlToImage;
  final String publishedAt;
}
