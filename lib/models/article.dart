import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Article {
  String id;
  String url;
  String title;
  String summary;
  Article({
    required this.id,
    required this.url,
    required this.title,
    required this.summary,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'summary': summary,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      url: map['url'] as String,
      title: map['title'] as String,
      summary: map['summary'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);
}
