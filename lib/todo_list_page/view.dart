import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ToDoListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      title: Text('ToDoList'),
      automaticallyImplyLeading: true,
    ),
    body: Container(
      child: Column(
        children: <Widget>[
          viewService.buildComponent('report'),
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
