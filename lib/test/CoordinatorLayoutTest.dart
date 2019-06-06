import 'package:flutter/material.dart';

class CoordinatorLayoutTestPage extends StatefulWidget {
  @override
  CoordinatorLayoutTestPageState createState() =>
      new CoordinatorLayoutTestPageState();
}

class CoordinatorLayoutTestPageState extends State<CoordinatorLayoutTestPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          _bar(),
          //单个控件
          _head(),
          //List
          _list(),
          //GridList
          _gridList(),
        ],
      ),
    );
  }

  /// grid
  SliverPadding _gridList() {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: 18.0,
            crossAxisSpacing: 24.0),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return getItemContainer(index);
          },
          childCount: 16,
        ),
      ),
    );
  }

  ///grid内容
  Widget getItemContainer(int index) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'grid title $index',
            style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
          ),
          Text(
            'grid content $index',
            style: TextStyle(fontSize: 14.0, color: Colors.greenAccent),
          ),
          Text(
            'grid tip $index',
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  ///list
  SliverFixedExtentList _list() {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _liveRemainContent(index);
          },
          childCount: 10,
        ),
        itemExtent: 48.0);
  }

  ///list Item
  Widget _liveRemainContent(int index) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          padding: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: Colors.grey, width: 0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('我的标题$index',
                      style:
                          TextStyle(fontSize: 17.0, color: Colors.blueAccent))
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }

  ///直播指南
  SliverToBoxAdapter _head() {
    return SliverToBoxAdapter(
      child: Container(
        height: 44.0,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.green),
      ),
    );
  }

  ///appBar
  Widget _bar() {
    return SliverAppBar(
      //标题居中
      centerTitle: true,
      //展开高度
      expandedHeight: 200.0,
      //固定在顶部
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(' FlexibleSpaceBar'),
      ),
    );
  }
}
