import 'package:fish_redux/fish_redux.dart';

class mineState implements Cloneable<mineState> {

  @override
  mineState clone() {
    return mineState();
  }
}

mineState initState(Map<String, dynamic> args) {
  return mineState();
}
