// To parse this JSON data, do
//
//     final newsApi = newsApiFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

NewsApi newsApiFromJson(String str) => NewsApi.fromJson(json.decode(str));

String newsApiToJson(NewsApi data) => json.encode(data.toJson());

class NewsApi {
  NewsApi({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<Article>? articles;

  factory NewsApi.fromJson(Map<String, dynamic> json) => NewsApi(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(
          articles!.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  Id? id;
  Name? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]],
        name: nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
      };
}

enum Id { TECHCRUNCH }

final idValues = EnumValues({"techcrunch": Id.TECHCRUNCH});

enum Name { TECH_CRUNCH }

final nameValues = EnumValues({"TechCrunch": Name.TECH_CRUNCH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));

    return reverseMap;
  }
}
