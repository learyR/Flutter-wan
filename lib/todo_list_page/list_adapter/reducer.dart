import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_wan/todo_component/action.dart' as todo_action;
import 'package:flutter_wan/todo_component/state.dart';

import '../state.dart';
import 'action.dart';

Reducer<ToDoListState> buildReducer() {
  return asReducer(<Object, Reducer<ToDoListState>>{
    ToDoListAction.add: _add,
    todo_action.ToDoAction.remove: _remove
  });
}

ToDoListState _add(ToDoListState state, Action action) {
  final ToDoState toDo = action.payload;
  final ToDoListState newState = state.clone();
  newState.toDos.add(toDo);
  return newState;
}

ToDoListState _remove(ToDoListState state, Action action) {
  final String unique = action.payload;
  final ToDoListState newState = state.clone();
  newState.toDos.removeWhere((ToDoState state) => state.uniqueId == unique);
  return newState;
}
