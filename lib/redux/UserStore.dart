import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wan/common/CommonState.dart';
import 'package:flutter_wan/model/User.dart';

class UserStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<CommonState, User>(
      ///通过 StoreConnector 关联 GSYState 中的 User
      converter: (store) => store.state.userInfo,
      builder: (context, userInfo) {
        return new Column(
          children: <Widget>[
            new Text(userInfo.userName ?? "---"),
//            new Text(sprintf("%s 岁", userInfo.age ?? "---")),
//            new Text(sprintf("性别 %s ", userInfo.sex ?? "---")),
//            new Text(sprintf("身高 %s cm", userInfo.height ?? "---"))
          ],
        );
      },
    );
  }
}
