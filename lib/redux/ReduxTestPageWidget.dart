import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wan/common/CommonState.dart';
import 'package:flutter_wan/model/User.dart';

import 'UserReducer.dart';

class ReduxTestPage extends StatefulWidget {
  @override
  ReduxTestPageState createState() => new ReduxTestPageState();
}

class ReduxTestPageState extends State<ReduxTestPage> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<CommonState>(builder: (context, store) {
      return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text("Redux测试"),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(store.state.userInfo.userName),
              new Text(store.state.userInfo.age.toString() + "岁"),
              new Text("性别 " + store.state.userInfo.sex),
              new Text("身高 " + store.state.userInfo.height.toString() + "cm"),
              new FlatButton(
                  onPressed: () {
                    StoreProvider.of<CommonState>(context)?.dispatch(
                        new UpdateUserAction(
                            new User("Flutter", 1, "男", 10000)));
                  },
                  child: new Text("数据修改"),
                  color: Colors.blue),
            ],
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ReduxTestPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

//class ReduxTestPageWidget extends StatelessWidget {
//  static final String sName = "/";
//
//  final store = new Store<CommonState>(appReducer,
//      initialState: new CommonState(
//        userInfo: new User("leary", 18, "男", 178),
//      ));
//
//  @override
//  Widget build(BuildContext context) {
//
//  }
//}
