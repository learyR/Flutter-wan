import 'package:flutter/material.dart';
import 'package:flutter_wan/global_store/state.dart';
import 'package:flutter_wan/todo_component/state.dart';

class ToDoEditState implements GlobalBaseState<ToDoEditState> {
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
      ..toDo = toDo
      ..themeColor = themeColor;
  }

  @override
  Color themeColor;
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
