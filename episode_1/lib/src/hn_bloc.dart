import 'dart:async';
import 'dart:collection';

import 'package:episode_1/src/article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

enum StoriesType { topStories, newStories }

class HackerNewsBloc {
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  var _articles = <Article>[];

  Sink<StoriesType> get storiesType => _storiesTypeController.sink;
  final _storiesTypeController = StreamController<StoriesType>();

  static List<int> _newIds = [
    22278231,
    22281095,
    22279520,
    22281178,
    22282554,
    22276184,
    22283653,
    22282183,
    22275295,
    22281801,
    22283469,
    22282205,
    22279051,
    22281279,
    22282019,
    22279585,
    22264711,
    22281210,
    22265654,
    22271400,
    22282612,
    22279308,
    22275550,
    22274043,
    22281248,
    22280939,
    22281280,
    22278602,
    22274938
  ]; //articles;

  static List<int> _topIds = [
    22283386,
    22283673,
    22281338,
    22282150,
    22282583,
    22280753,
    22282452,
    22282018,
    22271214,
    22277417,
    22282756,
    22281619,
    22282562,
    22282169,
    22281205,
    22281486,
    22282176,
    22282458,
    22281615,
    22282333,
    22277730,
    22280879,
    22281832,
    22282049,
    22271087,
    22283387,
    22281915,
    22275310,
    22280433,
  ];

  Stream<bool> get isLoading => _isLoadingSubject.stream;
  final _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  HackerNewsBloc() {
    _getArticlesAndUpdate(_topIds);

    _storiesTypeController.stream.listen((storiesType) {
      List<int> ids;
      if (storiesType == StoriesType.newStories) {
        ids = _newIds;
      } else {
        ids = _topIds;
      }
      _getArticlesAndUpdate(ids);
    });
  }

  void _getArticlesAndUpdate(List<int> ids) async {
    _isLoadingSubject.add(true);
    await _updateArticles(ids);
    _articlesSubject.add(UnmodifiableListView(_articles));
    _isLoadingSubject.add(false);
  }

  Stream<List<Article>> get articles => _articlesSubject.stream;

  Future<Article> _getArticle(int id) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyResponse = await http.get(storyUrl);
    if (storyResponse.statusCode == 200) {
      return parseArticle(storyResponse.body);
    }
  }

  Future<Null> _updateArticles(List<int> articleIds) async {
    final futureArticles = articleIds.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }
}
