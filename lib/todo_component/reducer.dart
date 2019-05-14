import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ToDoState> buildReducer() {
  return asReducer(
    <Object, Reducer<ToDoState>>{
      ToDoAction.edit: _edit,
      ToDoAction.done: _markDown,
    },
  );
}

ToDoState _markDown(ToDoState state, Action action) {
  final String uniqueId = action.payload;
  if (state.uniqueId == uniqueId) {
    return state.clone()..isDone = !state.isDone;
  }
  return state;
}

ToDoState _edit(ToDoState state, Action action) {
  final ToDoState toDo = action.payload;
  if (state.uniqueId == toDo.uniqueId) {
    return state.clone()..isDone = state.isDone;
  }
  return state;
}