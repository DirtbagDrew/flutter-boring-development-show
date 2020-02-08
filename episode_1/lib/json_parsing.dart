import 'dart:convert';

import 'package:built_value/built_value.dart';
part 'json_parsing.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  int get id;
  factory Article([Function(ArticleBuilder) updates]) = _$Article;
  Article._();
}

// class Article {
//   final String text;
//   final String url;
//   final String by;
//   final int time;
//   final int score;

//   const Article({
//     this.text,
//     this.url,
//     this.by,
//     this.time,
//     this.score,
//   });

//   factory Article.fromJson(Map<String, dynamic> json) {
//     if (json == null) {
//       return null;
//     }
//     return Article(
//       text: json['text'] ?? '[null]',
//       url: json['url'] ?? '[null]',
//       by: json['by'] ?? '[null]',
//       time: json['time'],
//       score: json['score'],
//     );
//   }
// }

List<int> parseTopStories(String jsonStr) {
  return [];
  // final parsedJson = jsonDecode(jsonStr);
  // final listOfIds = List<int>.from(parsedJson);
  // return listOfIds;
}

Article parseArticle(String jsonStr) {
  return null;
  // final parsedJson = jsonDecode(jsonStr);
  // Article article = Article.fromJson(parsedJson);
  // return article;
}
