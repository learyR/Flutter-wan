import 'package:flutter/material.dart';
import 'package:flutter_wan/component/popup_window_component.dart';

class PopupWindowTest extends StatefulWidget {
  @override
  PopupWindowTestState createState() => new PopupWindowTestState();
}

class PopupWindowTestState extends State<PopupWindowTest> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('PopupWindowTest'),
        ),
        body: Center(
          child: PopupWindowComponent(
            child: Icon(Icons.visibility),
          ),
        ));
  }
}
