import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ToDoListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: Text(state.title),
      actions: <Widget>[
        RaisedButton(
            padding: const EdgeInsets.only(
                left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
            color: Colors.blue,
            child: const Text('Change theme',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis),
            onPressed: () {
              dispatch(ToDoListActionCreator.onChangeTheme());
            }),
      ],
    ),
    body: Container(
      child: Column(
        children: <Widget>[
          Container(child: viewService.buildComponent('report')),
          Container(child: viewService.buildComponent('report_one')),
          Expanded(
            child: ListView.builder(
                itemCount: adapter.itemCount, itemBuilder: adapter.itemBuilder),
          )
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => dispatch(ToDoListActionCreator.onAddAction()),
      tooltip: 'Add',
      child: Icon(Icons.add),
    ),
  );
}
