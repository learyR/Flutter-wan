import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';

import 'FullScreenPage.dart';

class CustomControllerTest extends StatefulWidget {
  @override
  CustomControllerTestState createState() => new CustomControllerTestState();
}

class CustomControllerTestState extends State<CustomControllerTest> {
  CustomController controller;

  Widget _buildFullScreenVideo(
      BuildContext context,
      Animation<double> animation,
      CustomControllerProvider controllerProvider) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: controllerProvider,
      ),
    );
  }

  AnimatedWidget _defaultRoutePageBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      CustomControllerProvider controllerProvider) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return _buildFullScreenVideo(context, animation, controllerProvider);
      },
    );
  }

  Widget _fullScreenRoutePageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    var controllerProvider = CustomControllerProvider(
      controller: controller,
      child: FullScreenTest(),
    );
    return _defaultRoutePageBuilder(
        context, animation, secondaryAnimation, controllerProvider);
  }

  Future<dynamic> _pushFullScreenWidget(BuildContext context) async {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    final TransitionRoute<Null> route = PageRouteBuilder<Null>(
      settings: RouteSettings(isInitialRoute: false),
      pageBuilder: _fullScreenRoutePageBuilder,
    );

    SystemChrome.setEnabledSystemUIOverlays([]);
    if (isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    await Navigator.of(context).push(route);
    bool isKeptOn = await Screen.isKeptOn;
    if (isKeptOn) {
      Screen.keepOn(false);
    }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CustomControllerTest'),
      ),
      body: CustomControllerProvider(
        controller: controller,
        increment: _incrementCount,
        reduce: _reduceCount,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'pic',
              child: Container(
                height: 200.0,
                width: double.infinity,
                child: Image.network(
                    'https://upload-images.jianshu.io/upload_images/6431170-2678b72c0710102b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240'),
              ),
            ),
            TestWidgetA(),
            Test(),
            TestWidgetB(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pushFullScreenWidget(context);
        },
        tooltip: '进入全屏',
        child: Icon(Icons.fullscreen),
      ),
    );
  }

  @override
  void initState() {
    controller = CustomController(count: 0);
    super.initState();
  }

  void _incrementCount() {
    setState(() {
      controller.increment();
    });
  }

  _reduceCount() {
    setState(() {
      controller.reduce();
    });
  }
}

class TestWidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllerProvider = CustomControllerProvider.of(context);
    var controller = controllerProvider.controller;
    print('leary_A: ' + controller.count.toString());
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: controllerProvider.increment,
          child: Text('+'),
          textColor: Colors.black,
        ),
      ],
    );
  }
}

class TestWidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllerProvider = CustomControllerProvider.of(context);
    var controller = controllerProvider.controller;
    print('leary_B: ' + controller.count.toString());
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: controllerProvider.reduce,
          child: Text('-'),
          textColor: Colors.black,
        ),
      ],
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllerProvider = CustomControllerProvider.of(context);
    var controller = controllerProvider.controller;
    return Text(controller.count.toString(),
        style: TextStyle(
          fontSize: 20.0,
        ));
  }
}

class CustomController extends ChangeNotifier {
  int count;

  CustomController({this.count});

  void increment() {
    count++;
    notifyListeners();
  }

  void reduce() {
    count--;
    notifyListeners();
  }
}

class CustomControllerProvider extends InheritedWidget {
  final CustomController controller;
  final Function increment;
  final Function reduce;

  CustomControllerProvider(
      {Key key, this.controller, this.increment, this.reduce, Widget child})
      : super(key: key, child: child);

  static CustomControllerProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CustomControllerProvider);
  }

  @override
  bool updateShouldNotify(CustomControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
