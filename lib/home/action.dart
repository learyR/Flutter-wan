import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum mineAction { action }

class MineActionCreator {
  static Action onAction() {
    return const Action(mineAction.action);
  }
}
