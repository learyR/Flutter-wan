import 'package:flutter_wan/model/User.dart';
import 'package:flutter_wan/redux/UserReducer.dart';

class CommonState {
  User userInfo;

  CommonState({this.userInfo});
}

CommonState appReducer(CommonState state, action) {
  ///通过自定义 UserReducer 将 State 内的 userInfo 和 action 关联在一起
  return CommonState(userInfo: UserReducer(state.userInfo, action));
}
