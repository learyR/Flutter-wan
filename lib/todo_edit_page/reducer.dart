import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ToDoEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<ToDoEditState>>{
      ToDoEditAction.update: _onUpdate,
    },
  );
}

ToDoEditState _onUpdate(ToDoEditState state, Action action) {
  final Map<String, String> update = action.payload ?? <String, String>{};
  final ToDoEditState newState = state.clone();
  newState.toDo.title = update['name'] ?? newState.toDo.title;
  newState.toDo.desc = update['desc'] ?? newState.toDo.desc;
  return newState;
}
