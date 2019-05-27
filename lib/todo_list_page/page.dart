import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'report_component/component.dart';
import 'state.dart';
import 'view.dart';

class ToDoListPage extends Page<ToDoListState, Map<String, dynamic>>
    with PrivateReducerMixin<ToDoListState> {
  ToDoListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ToDoListState>(
              adapter: ToDoListAdapter(),
              slots: <String, Dependent<ToDoListState>>{
                'report': ReportComponent().asDependent(ReportConnector()),
                'report_one': ReportComponent().asDependent(ReportConnector()),
              }),
          middleware: <Middleware<ToDoListState>>[
            logMiddleware(tag: 'ToDoListPage')
          ],
        );
}
