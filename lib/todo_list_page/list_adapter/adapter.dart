import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_wan/todo_component/component.dart';
import 'package:flutter_wan/todo_component/state.dart';

import '../state.dart';
import 'reducer.dart';

class ToDoListAdapter extends DynamicFlowAdapter<ToDoListState> {
  ToDoListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'toDo': ToDoComponent(),
          },
          connector: _ToDoListConnector(),
          reducer: buildReducer(),
        );
}

class _ToDoListConnector extends ConnOp<ToDoListState, List<ItemBean>> {
  @override
  List<ItemBean> get(ToDoListState state) {
    if (state.toDos?.isNotEmpty == true) {
      return state.toDos
          .map<ItemBean>((ToDoState data) => ItemBean('toDo', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(ToDoListState state, List<ItemBean> items) {
    if (items?.isNotEmpty == true) {
      state.toDos = List<ToDoState>.from(
          items.map<ToDoState>((ItemBean bean) => bean.data).toList());
    } else {
      state.toDos = <ToDoState>[];
    }
  }
}
