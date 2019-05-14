import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ToDoComponent extends Component<ToDoState> {
  ToDoComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ToDoState>(
                adapter: null,
                slots: <String, Dependent<ToDoState>>{
                }),);

}
