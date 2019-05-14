import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    ReportState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(8.0),
    color: Colors.blue,
    child: Row(
      children: <Widget>[
        Container(
          child: Icon(Icons.report),
          margin: EdgeInsets.only(right: 8.0),
        ),
        Text(
          'Total${state.total} tasks,${state.done} done.',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        )
      ],
    ),
  );
}
