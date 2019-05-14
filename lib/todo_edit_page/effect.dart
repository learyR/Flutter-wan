import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/todo_component/state.dart';

import 'action.dart';
import 'state.dart';

Effect<ToDoEditState> buildEffect() {
  return combineEffects(<Object, Effect<ToDoEditState>>{
    Lifecycle.initState: _init,
    ToDoEditAction.done: _onDone,
  });
}

void _init(Action action, Context<ToDoEditState> ctx) {
  ctx.state.nameEditController.addListener(() {
    ctx.dispatch(
        ToDoEditActionCreator.update(ctx.state.nameEditController.text, null));
  });
  ctx.state.descEditController.addListener(() {
    ctx.dispatch(
        ToDoEditActionCreator.update(null, ctx.state.descEditController.text));
  });
}

void _onDone(Action action, Context<ToDoEditState> ctx) {
  Navigator.of(ctx.context).pop<ToDoState>(ctx.state.toDo);
}
