import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//class TestMainPage extends StatelessWidget {
//  final List list;
//
//  TestMainPage({Key key, @required this.list}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: '路由测试',
//      home: new SampleAppPage(list),
//    );
//  }
//}

class SampleAppPage extends StatefulWidget {
  final List list;

  SampleAppPage({this.list});

  @override
  SampleAppPageState createState() => new SampleAppPageState(list);
}

class SampleAppPageState extends State<SampleAppPage>
    with WidgetsBindingObserver {
  List list = [];

  SampleAppPageState(List list) {}
  AppLifecycleState _lastLifecyleState;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("标题"),
          leading: InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(
                    context,
                    new Text(
                        'The most recent lifecycle state this widget observed was: $_lastLifecyleState.',
                        textDirection: TextDirection.ltr));
              })),
      body: getBody(),
    );
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  @override
  void initState() {
    loadData();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecyleState = state;
    });
    Tooltip(message: state.toString());
  }

  @override
  void didUpdateWidget(SampleAppPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  ListView getListView() => new ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Text("Row ${list[i]["title"]}"));
  }

  showLoadingDialog() {
    if (list.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  void loadData() async {
    String dataUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response re = await http.get(dataUrl);
    setState(() {
      list = json.decode(re.body);
    });
  }
}
