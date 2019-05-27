import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wan/app.dart';
import 'package:flutter_wan/redux/ReduxTestPageWidget.dart';
import 'package:flutter_wan/test/TestApp.dart';
import 'package:redux/redux.dart';

import 'common/CommonState.dart';
import 'model/User.dart';
import 'redux/UserReducer.dart';
import 'test/TabBarBottomPageWidget.dart';
import 'test/TabBarPageWidget.dart';
import 'test/TextFieldTest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final String sName = "/";

  final store = new Store<CommonState>(appReducer,
      initialState: new CommonState(
        userInfo: new User("leary", 18, "男", 178),
      ));

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
//    return MaterialApp(
//
//    );
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
            child: new Text("跳转到下一个页面")),
        new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new ReduxTestPage();
              }));
            },
            child: new Text("Redux测试")),
        new FlatButton(
            onPressed: () {
              _getStore(context)?.dispatch(
                  new UpdateUserAction(new User("Hello World", 25, "女", 180)));
            },
            child: new Text("数据修改"),
            color: Colors.blue),
        new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new FishReduxTest();
              }));
            },
            child: new Text("Fish ReduxDemo")),
        new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new EditTextElement();
              }));
            },
            child: new Text("输入框测试")),
      ],
    );
  }

  Store<CommonState> _getStore(BuildContext context) {
    if (context == null) {
      print("YYState null");
      return null;
    }
    return StoreProvider.of(context);
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
