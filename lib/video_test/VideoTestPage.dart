import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rongcloud_im_plugin/chatroom_info.dart';
import 'package:rongcloud_im_plugin/message.dart';
import 'package:rongcloud_im_plugin/rc_common_define.dart';
import 'package:rongcloud_im_plugin/rc_status_define.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:rongcloud_im_plugin/text_message.dart';
import 'package:video_player/video_player.dart';

import 'material_controls.dart';

class VideoTestPage extends StatefulWidget {
  @override
  VideoTestPageState createState() => new VideoTestPageState();
}

class VideoTestPageState extends State<VideoTestPage> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('VideoTest'),
        ),
        body: Column(
          children: <Widget>[
            Chewie(controller: _chewieController),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () => onSendMessage(),
                        child: Text("sendMessage"),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () => onJoinChatRoom(),
                        child: Text("onJoinChatRoom"),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () => onGetChatRoomInfo(),
                        child: Text("onGetChatRoomInfo"),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4');
    _chewieController = ChewieController(
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      videoPlayerController: _controller,
      aspectRatio: 3 / 2,
      overlay: Container(
        alignment: Alignment.topCenter,
        color: Colors.black26,
        height: 40.0,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
            Text(
              '标题栏',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      autoPlay: false,
      autoInitialize: true,
      looping: false,
      customControls: MyMaterialControls(),
      placeholder: Container(
        color: Colors.grey,
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.white,
        handleColor: Colors.white,
        backgroundColor: Colors.black,
        //预加载进度条
        bufferedColor: Colors.grey,
      ),
    );
  }

  onSendMessage() async {
    TextMessage txtMessage = new TextMessage();
    txtMessage.content = "这条消息来自 flutter";
    Message msg = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, "ios", txtMessage);
    print("send message start senderUserId = " + msg.senderUserId);
  }

  onJoinChatRoom() {
    RongcloudImPlugin.joinChatRoom("testchatroomId", 10);
  }

  onQuitChatRoom() {
    RongcloudImPlugin.quitChatRoom("testchatroomId");
  }

  onGetChatRoomInfo() async {
    ChatRoomInfo chatRoomInfo = await RongcloudImPlugin.getChatRoomInfo(
        "testchatroomId", 10, RCChatRoomMemberOrder.Desc);
    print("onGetChatRoomInfo targetId =" + chatRoomInfo.targetId);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
