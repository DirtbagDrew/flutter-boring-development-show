import 'dart:collection';

import 'package:episode_1/src/hn_bloc.dart';
import 'package:flutter/material.dart';
import 'package:episode_1/src/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  final hnBloc = HackerNewsBloc();
  runApp(MyApp(bloc: hnBloc));
}

class MyApp extends StatelessWidget {
  final HackerNewsBloc bloc;
  MyApp({Key key, this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(
        title: 'Flutter Hacker news',
        bloc: bloc,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final HackerNewsBloc bloc;
  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: LoadingInfo(widget.bloc.isLoading),
      ),
      body: Center(
        child: StreamBuilder<UnmodifiableListView<Article>>(
          stream: widget.bloc.articles,
          initialData: UnmodifiableListView<Article>([]),
          builder: (context, snapshot) => ListView(
            children: snapshot.data.map(_buildItem).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              title: Text('Top stories'), icon: Icon(Icons.arrow_drop_up)),
          BottomNavigationBarItem(
              title: Text('New stories'), icon: Icon(Icons.new_releases)),
        ],
        onTap: (index) {
          StoriesType storiesType;
          if (index == 0) {
            storiesType = StoriesType.topStories;
          } else {
            storiesType = StoriesType.newStories;
          }
          widget.bloc.storiesType.add(storiesType);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.id.toString()),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
          article.title,
          style: TextStyle(fontSize: 24),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(article.type),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  if (await canLaunch(article.url)) {
                    await launch(article.url);
                  } else {
                    throw 'Could not launch ${article.url}';
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LoadingInfo extends StatefulWidget {
  Stream<bool> _isLoading;
  LoadingInfo(this._isLoading);
  @override
  State<StatefulWidget> createState() {
    return LoadingInfoState();
  }
}

class LoadingInfoState extends State<LoadingInfo>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._isLoading,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        // if (snapshot.hasData && snapshot.data) {
        _controller.forward().then((f) => _controller.reverse());

        return FadeTransition(
          child: Icon(
            FontAwesomeIcons.hackerNewsSquare,
            color: Colors.white,
          ),
          opacity: Tween(begin: 0.5, end: 1.0).animate(
              CurvedAnimation(curve: Curves.easeIn, parent: _controller)),
        );
        // }
        // return Container();
      },
    );
  }
}
