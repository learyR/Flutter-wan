import 'package:flutter/material.dart';
import 'package:flutter_wan/test/TestApp.dart';

import 'test/TabBarBottomPageWidget.dart';
import 'test/TabBarPageWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Title"),
      ),
      body: Collom(),
    );
  }
}

class Collom extends StatelessWidget {
  final List datas = ["苹果", '橘子', '香蕉'];

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new TabBarPageWidget();
              }));
            },
            child: new Text("Top tab")),
        new FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new TabBarBottomPageWidget();
              }));
            },
            child: new Text("Bootom Tab")),
        new FlatButton(
            onPressed: () {
              _navigateAndDispalySelection(context);
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (context) => new TestMainPage(list: datas)));
            },
            child: new Text("跳转到下一个页面"))
      ],
    );
  }

  _navigateAndDispalySelection(BuildContext context) async {
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new SampleAppPage(list: datas)));
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text("$result")));
  }
}
