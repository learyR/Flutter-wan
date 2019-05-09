import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class minePage extends Page<mineState, Map<String, dynamic>> {
  minePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<mineState>(
                adapter: null,
                slots: <String, Dependent<mineState>>{
                }),
            middleware: <Middleware<mineState>>[
            ],);

}
