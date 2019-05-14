import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_wan/todo_component/state.dart';
import 'package:flutter_wan/todo_list_page/report_component/state.dart';

class ToDoListState implements Cloneable<ToDoListState> {
  List<ToDoState> toDos;

  @override
  ToDoListState clone() {
    return ToDoListState()..toDos = toDos;
  }
}

ToDoListState initState(Map<String, dynamic> args) {
  return ToDoListState();
}

class ReportConnector extends ConnOp<ToDoListState, ReportState> {
  @override
  ReportState get(ToDoListState state) {
    final ReportState reportState = ReportState();
    reportState.total = state.toDos.length;
    reportState.done =
        state.toDos.where((ToDoState tds) => tds.isDone).toList().length;
    return reportState;
  }

  @override
  void set(ToDoListState state, ReportState subState) {}
}
