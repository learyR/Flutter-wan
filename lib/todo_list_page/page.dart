import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'report_component/component.dart';
import 'state.dart';
import 'view.dart';

class ToDoListPage extends Page<ToDoListState, Map<String, dynamic>> {
  ToDoListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ToDoListState>(
              adapter: ToDoListAdapter(),
              slots: <String, Dependent<ToDoListState>>{
                'report': ReportConnector() + ReportComponent()
              }),
          middleware: <Middleware<ToDoListState>>[
            logMiddleware(tag: 'ToDoListPage')
          ],
        );
}
