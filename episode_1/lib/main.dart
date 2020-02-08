import 'package:flutter/material.dart';
import 'src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            await new Future.delayed(const Duration(seconds: 1));
            setState(() {
              _articles.removeAt(0);
            });
            return;
          },
          child: ListView(
            children: _articles.map(_buildItem).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.text),
      padding: const EdgeInsets.all(16.0),
      child: new ExpansionTile(
        title: new Text(
          article.text,
          style: new TextStyle(fontSize: 24),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("${article.commentsCount} comments"),
              new IconButton(
                icon: new Icon(Icons.launch),
                onPressed: () async {
                  String url = 'https://${article.domain}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
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
