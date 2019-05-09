import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<mineState> buildEffect() {
  return combineEffects(<Object, Effect<mineState>>{
    mineAction.action: _onAction,
  });
}

void _onAction(Action action, Context<mineState> ctx) {
}
