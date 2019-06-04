import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/todo_component/state.dart';

import 'action.dart';
import 'list_adapter/action.dart' as list_action;
import 'state.dart';

Effect<ToDoListState> buildEffect() {
  return combineEffects(<Object, Effect<ToDoListState>>{
    Lifecycle.initState: _init,
    ToDoListAction.onAdd: _onAdd,
  });
}

void _onAdd(Action action, Context<ToDoListState> ctx) {
  Navigator.of(ctx.context)
      .pushNamed('todo_edit', arguments: null)
      .then((dynamic toDo) {
    if (toDo != null &&
        (toDo.title?.isNotEmpty == true || toDo.desc?.isNotEmpty == true)) {
      ctx.dispatch(list_action.ToDoListActionCreator.add(toDo));
    }
  });
}

void _init(Action action, Context<ToDoListState> ctx) {
  final List<ToDoState> initToDos = <ToDoState>[
    ToDoState(
      uniqueId: '0',
      title: 'Hello world',
      desc: 'Learn how to program.',
      isDone: true,
    ),
    ToDoState(
      uniqueId: '1',
      title: 'Hello Flutter',
      desc: 'Learn how to build a flutter application.',
      isDone: true,
    ),
    ToDoState(
      uniqueId: '2',
      title: 'How Fish Redux',
      desc:
          'Learn how to use Fish Redux in a flutter application.\nHow Fish Redux\nHow Fish Redux',
      isDone: false,
    )
  ];
  ctx.dispatch(ToDoListActionCreator.initToDosAction(initToDos));
}
