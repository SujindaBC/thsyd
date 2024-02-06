import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  const News({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.source,
  });

  final String title;
  final String description;
  final String content;
  final String url;
  final String urlToImage;
  final Timestamp publishedAt;
  final String source;

  News copyWith({
    String? title,
    String? description,
    String? content,
    String? url,
    String? urlToImage,
    Timestamp? publishedAt,
    String? source,
  }) {
    return News(
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'source': source,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      url: map['url'] as String,
      urlToImage: map['urlToImage'] as String,
      publishedAt: map['publishedAt'] as Timestamp,
      source: map['source'] as String,
    );
  }
}
