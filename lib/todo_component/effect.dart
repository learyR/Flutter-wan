import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Effect<ToDoState> buildEffect() {
  return combineEffects(<Object, Effect<ToDoState>>{
    ToDoAction.onEdit: _onEdit,
    ToDoAction.onRemove: _onRemove,
  });
}

void _onEdit(Action action, Context<ToDoState> ctx) {
  if (action.payload == ctx.state.uniqueId) {
    Navigator.of(ctx.context)
        .pushNamed('todo_edit', arguments: ctx.state)
        .then((dynamic toDo) {
      if (toDo != null) {
        ctx.dispatch(ToDoActionCreator.editAction(toDo));
      }
    });
  }
}

void _onRemove(Action action, Context<ToDoState> ctx) async {
  final String select = await showDialog(
      context: ctx.context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text('Are you sure to delete "${ctx.state.title}"?'),
          actions: <Widget>[
            GestureDetector(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () => Navigator.of(buildContext).pop(),
            ),
            GestureDetector(
              child: Text(
                'Confirm',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () => Navigator.of(buildContext).pop('yes'),
            )
          ],
        );
      });
  if (select == 'yes') {
    ctx.dispatch(ToDoActionCreator.onRemoveAction(ctx.state.uniqueId));
  }
}
