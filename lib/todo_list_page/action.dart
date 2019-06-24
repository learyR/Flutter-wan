import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_wan/todo_component/state.dart';

enum ToDoListAction { initToDos, onAdd, onChangeTheme }

class ToDoListActionCreator {
  static Action initToDosAction(List<ToDoState> toDos) {
    return Action(ToDoListAction.initToDos, payload: toDos);
  }

  static Action onAddAction() {
    return const Action(ToDoListAction.onAdd);
  }

  static Action onChangeTheme() {
    return const Action(ToDoListAction.onChangeTheme);
  }
}
