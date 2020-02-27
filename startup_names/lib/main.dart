import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:random_words/random_words.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Names',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Startup Names'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final randomNames = generateWordPairs().take(1000).toList();
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: CustomScrollView(slivers: [
          SliverAppBar(
            // pinned: true,
            // floating: true,
            expandedHeight: 200,
            title: Text('hello'),
          ),
          SliverFilip(
            child: Container(
              color: Colors.red,
              child: Text('hi'),
              height: 150,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: SizedBox(
                            child: Container(
                              color: _randomColor.randomColor(),
                            ),
                            width: 24,
                            height: 24,
                          ),
                          title: Text(randomNames[index].asCamelCase),
                        ),
                      ),
                  childCount: randomNames.length),
            ),
          )
        ]
            // randomNames.map((wordPair) {
            //   return Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: ListTile(
            //       leading: SizedBox(
            //         child: Container(
            //           color: _randomColor.randomColor(),
            //         ),
            //         width: 24,
            //         height: 24,
            //       ),
            //       title: Text(wordPair.asCamelCase),
            //     ),
            //   );
            // }).toList(),
            ),
      ),
    );
  }
}

class SliverFilip extends SingleChildRenderObjectWidget {
  SliverFilip({Widget child, Key key}) : super(child: child, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverFilip();
  }
}

class RenderSliverFilip extends RenderSliverSingleBoxAdapter {
  RenderSliverFilip({
    RenderBox child,
  }) : super(child: child);

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child.size.width;
        break;
      case Axis.vertical:
        childExtent = child.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);

    final isOdd = constraints.scrollOffset.toInt().isOdd;

    geometry = SliverGeometry(
        scrollExtent: 50,
        paintExtent: 50,
        maxPaintExtent: 50,
        paintOrigin: constraints.scrollOffset * 2);
    setChildParentData(child, constraints, geometry);
  }
}
