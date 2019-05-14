import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/todo_component/state.dart';

class ToDoEditState implements Cloneable<ToDoEditState> {
  ToDoState toDo;
  TextEditingController nameEditController;
  TextEditingController descEditController;
  FocusNode focusNodeName;
  FocusNode focusNodeDesc;

  @override
  ToDoEditState clone() {
    return ToDoEditState()
      ..nameEditController = nameEditController
      ..descEditController = descEditController
      ..focusNodeName = focusNodeName
      ..focusNodeDesc = focusNodeDesc
      ..toDo = toDo;
  }
}

ToDoEditState initState(ToDoState args) {
  final ToDoEditState state = ToDoEditState();
  state.toDo = args?.clone() ?? ToDoState();
  state.nameEditController = TextEditingController(text: args?.title);
  state.descEditController = TextEditingController(text: args?.desc);
  state.focusNodeName = FocusNode();
  state.focusNodeDesc = FocusNode();
  return state;
}
