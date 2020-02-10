// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
// import 'package:episode_1/src/article.dart';
// import 'package:meta/meta.dart';
// import 'serializers.dart';
// part 'json_parsing.g.dart';

// abstract class Article implements Built<Article, ArticleBuilder> {
//   static Serializer<Article> get serializer => _$articleSerializer;

//   int get id;

//   @nullable
//   bool get deleted;

//   String get type;

//   String get by;

//   @nullable
//   int get time;

//   @nullable
//   String get text;

//   @nullable
//   bool get dead;

//   @nullable
//   int get parent;

//   @nullable
//   int get poll;

//   BuiltList<int> get kids;

//   @nullable
//   String get url;

//   @nullable
//   int get score;

//   @nullable
//   String get title;

//   BuiltList<int> get parts;

//   @nullable
//   int get descendants;

//   factory Article([Function(ArticleBuilder) updates]) = _$Article;
//   Article._();
// }

// List<int> parseTopStories(String jsonStr) {
//   return [];
//   // final parsedJson = jsonDecode(jsonStr);
//   // final listOfIds = List<int>.from(parsedJson);
//   // return listOfIds;
// }

// Article parseArticle(String jsonStr) {
//   final parsedJson = jsonDecode(jsonStr);
//   Article article =
//       standardSerializers.deserializeWith(Article.serializer, parsedJson);
//   return article;
// }
