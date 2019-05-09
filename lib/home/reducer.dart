import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<mineState> buildReducer() {
  return asReducer(
    <Object, Reducer<mineState>>{
      mineAction.action: _onAction,
    },
  );
}

mineState _onAction(mineState state, Action action) {
  final mineState newState = state.clone();
  return newState;
}
