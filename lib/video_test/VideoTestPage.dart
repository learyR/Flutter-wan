import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: Chewie(controller: _chewieController),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4');
    _chewieController = ChewieController(
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      videoPlayerController: _controller,
      aspectRatio: 9 / 7,
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
      autoPlay: true,
      looping: true,
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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
