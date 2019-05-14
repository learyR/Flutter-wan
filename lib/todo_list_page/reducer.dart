import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_wan/todo_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<ToDoListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ToDoListState>>{
      ToDoListAction.initToDos: _initToDosReducer,
    },
  );
}

ToDoListState _initToDosReducer(ToDoListState state, Action action) {
  final List<ToDoState> toDos = action.payload ?? <ToDoState>[];
  final ToDoListState newState = state.clone();
  newState.toDos = toDos;
  return newState;
}
