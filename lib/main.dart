import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wan/app.dart';
import 'package:flutter_wan/redux/ReduxTestPageWidget.dart';
import 'package:flutter_wan/test/CoorDinatorLayoutTest.dart';
import 'package:flutter_wan/test/TestApp.dart';
import 'package:flutter_wan/video_test/VideoTestPage.dart';
import 'package:redux/redux.dart';
import 'package:rongcloud_im_plugin/message.dart';
import 'package:rongcloud_im_plugin/message_factory.dart';
import 'package:rongcloud_im_plugin/rc_common_define.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

import 'common/CommonState.dart';
import 'custom_page_controller/CustomPageController.dart';
import 'model/User.dart';
import 'redux/UserReducer.dart';
import 'test/PopupWindowTest.dart';
import 'test/TabBarBottomPageWidget.dart';
import 'test/TabBarPageWidget.dart';
import 'test/TextFieldTest.dart';
import 'test/ViewPickerTest.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  static final String sName = "/";

  final store = new Store<CommonState>(appReducer,
      initialState: new CommonState(
        userInfo: new User("leary", 18, "男", 178),
      ));

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    //融云 appkey
    String RongAppKey = 'kj7swf8ok3un2';
    //用户 id
    String userId = 'leary';
    //通过用户 id 生成的对应融云 token
    String RongIMToken =
        '0h3H6oGkKkfOWoipmPCkWk3e2JLOkgnMCu6Hfbae6kCpjis4tibuUF0U55THbWE2WgnUuGtRiz+KiU4nt7WpDg==';

    //1.初始化 im SDK
    RongcloudImPlugin.init(RongAppKey);

    //2.配置 im SDK
    String confString = await DefaultAssetBundle.of(context)
        .loadString("assets/RCFlutterConf.json");
    Map confMap = json.decode(confString.toString());
    RongcloudImPlugin.config(confMap);

    //3.连接 im SDK
    int rc = await RongcloudImPlugin.connect(RongIMToken);
    print('connect result');
    print(rc);

    //4.刷新当前用户的用户信息
    String portraitUrl = "https://www.rongcloud.cn/pc/images/huawei-icon.png";
    RongcloudImPlugin.updateCurrentUserInfo(userId, "李四", portraitUrl);

    //5.设置监听回调，处理 native 层传递过来的事件
    RongcloudImPlugin.setRCNativeMethodCallHandler(_handler);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    setState(() {});
  }

//6.响应 native 的事件
  Future<dynamic> _handler(MethodCall methodCall) async {
    //当 im SDK 需要展示用户信息的时候，会回调此方法
    if (RCMethodCallBackKey.RefrechUserInfo == methodCall.method) {
      //开发者需要将用户信息传递给 SDK
      //如果本地有该用户的信息，那么直接传递给 SDK
      //如果本地没有该用户的信息，从 APP 服务获取后传递给 SDK
      String userId = methodCall.arguments;
      String name = "张三";
      String portraitUrl = "https://www.rongcloud.cn/pc/images/lizhi-icon.png";
      RongcloudImPlugin.refreshUserInfo(userId, name, portraitUrl);
    } else if (RCMethodCallBackKey.ReceiveMessage == methodCall.method) {
      //收到消息原生会触发此方法
      Map map = methodCall.arguments;
      print("messageMap=" + map.toString());
      int left = map["left"];
      print("left=" + left.toString());
      String messageString = map["message"];
      Message msg = MessageFactory.instance.string2Message(messageString);

      //会话类型，单聊/群聊/聊天室
      print("conversationType = " + msg.conversationType.toString());
      print("targetId = " + msg.targetId);
      print("senderUserId=" + msg.senderUserId);
    } else if (RCMethodCallBackKey.SendMessage == methodCall.method) {
      //发送消息会触发此回调，通知 flutter 层消息发送结果
      // {"messageId":12,"status":30}
      // messageId 为本地数据库自增字段
      // status 结果参见 RCMessageSentStatus 的枚举值
      Map map = methodCall.arguments;
      print("message sent result " + map.toString());
    } else if (RCMethodCallBackKey.JoinChatRoom == methodCall.method) {
      //加入聊天室的回调
      //targetId 聊天室 id
      //status 参见 RCOperationStatus
      //{"targetId":targetId,"status":0};
      Map map = methodCall.arguments;
      print("join chatroom resulut =" + map.toString());
    } else if (RCMethodCallBackKey.QuitChatRoom == methodCall.method) {
      //退出聊天室的回调
      //targetId 聊天室 id
      //status 参见 RCOperationStatus
      //{"targetId":targetId,"status":0};
      Map map = methodCall.arguments;
      print("quit chatroom resulut =" + map.toString());
    } else if (RCMethodCallBackKey.UploadMediaProgress == methodCall.method) {
      //上传图片进度的回调
      //{"messageId",messageId,"progress",99}
      Map map = methodCall.arguments;
      print("upload image message progress = " + map.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        initialRoute: 'root',
      ),
    );

//    return MaterialApp(
//
//    );
  }
}

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  static final String sName = "/";
//
//  final store = new Store<CommonState>(appReducer,
//      initialState: new CommonState(
//        userInfo: new User("leary", 18, "男", 178),
//      ));
//
//  @override
//  Widget build(BuildContext context) {
//    return new StoreProvider(
//      store: store,
//      child: MaterialApp(
//        title: 'Flutter Demo',
//        theme: ThemeData(
//          primarySwatch: Colors.blue,
//        ),
//        home: MyHomePage(),
//      ),
//    );
//
////    return MaterialApp(
////
////    );
//  }
//}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Title"),
      ),
      body: Collom(),
    );
  }
}

class Collom extends StatelessWidget {
  final List datas = ["苹果", '橘子', '香蕉'];

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new TabBarPageWidget();
              }));
            },
            child: new Text("Top tab")),
        new FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new TabBarBottomPageWidget();
              }));
            },
            child: new Text("Bootom Tab")),
        new FlatButton(
            onPressed: () {
              _navigateAndDispalySelection(context);
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (context) => new TestMainPage(list: datas)));
            },
            child: new Text("跳转到下一个页面")),
        new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new ReduxTestPage();
              }));
            },
            child: new Text("Redux测试")),
        new FlatButton(
            onPressed: () {
              _getStore(context)?.dispatch(
                  new UpdateUserAction(new User("Hello World", 25, "女", 180)));
            },
            child: new Text("数据修改"),
            color: Colors.blue),
        new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new FishReduxTest();
              }));
            },
            child: new Text("Fish ReduxDemo")),
        new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new EditTextElement();
              }));
            },
            child: new Text("输入框测试")),
        new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new ViewPickerTest();
              }));
            },
            child: new Text("调用相机插件")),
        FlatButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => new PopupWindowTest())),
          child: Text('popuWindowTest'),
        ),
        FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new CoordinatorLayoutTestPage())),
          child: Text('CoordinatorLayoutTest'),
        ),
        FlatButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => new VideoTestPage())),
          child: Text('视频播放测试'),
        ),
        FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new CustomControllerTest())),
          child: Text('CustomControllerTest'),
        ),
      ],
    );
  }

  Store<CommonState> _getStore(BuildContext context) {
    if (context == null) {
      print("YYState null");
      return null;
    }
    return StoreProvider.of(context);
  }

  _navigateAndDispalySelection(BuildContext context) async {
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new SampleAppPage(list: datas)));
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text("$result")));
  }
}
