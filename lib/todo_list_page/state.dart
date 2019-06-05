import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_wan/todo_component/state.dart';
import 'package:flutter_wan/todo_list_page/report_component/state.dart';

class ToDoListState implements Cloneable<ToDoListState> {
  List<ToDoState> toDos;
  String title = 'qoo';
  ReportState reportState;

  @override
  ToDoListState clone() {
    return ToDoListState()
      ..toDos = toDos
      ..title = title
      ..reportState = reportState;
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
  ToDoListState set(ToDoListState state, ReportState subState) {
    if (subState == 1) {
      var total = subState.total;
      return state.clone()..title = '总共 + $total';
    }
    return state;
  }
}
