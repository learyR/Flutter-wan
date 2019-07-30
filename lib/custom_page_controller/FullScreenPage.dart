import 'package:flutter/material.dart';

import 'CustomPageController.dart';

class FullScreenTest extends StatefulWidget {
  @override
  FullScreenTestState createState() => new FullScreenTestState();
}

class FullScreenTestState extends State<FullScreenTest> {
  CustomController controller;

  void _incrementCount() {
    print('leary_fullScreen:' + controller.count.toString());

    setState(() {
      controller.increment();
      print('leary_fullScreen:' + controller.count.toString());
    });
  }

  void _reduceCount() {
    setState(() {
      controller.reduce();
      print('leary_fullScreen:' + controller.count.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    controller = CustomControllerProvider.of(context).controller;

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _incrementCount,
            heroTag: 'tag1',
            child: Text('增加'),
          ),
          FloatingActionButton(
            onPressed: _reduceCount,
            heroTag: 'tag2',
            child: Text('减少'),
          ),
          FloatingActionButton(
            onPressed: () => Navigator.of(context).pop(),
            heroTag: 'tag3',
            child: Icon(Icons.fullscreen_exit),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 50.0,
            left: 20.0,
            child: Container(
              height: 80.0,
              width: 80.0,
              alignment: Alignment.center,
              color: Colors.black26,
              child: Text(controller.count.toString()),
            ),
          ),
          Hero(
              tag: 'pic',
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.network(
                    'https://upload-images.jianshu.io/upload_images/6431170-2678b72c0710102b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240'),
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
