import 'package:flutter/material.dart';

class RowSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Row'),
      ),
    );
  }

  Widget _buildRow() {
    return new Row(
      children: <Widget>[
        new Icon(Icons.info),
        new Icon(Icons.map),
        new Icon(Icons.email)
      ],
    );
  }
}
