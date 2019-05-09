import 'package:flutter/material.dart';

import 'TabBarPageFirst.dart';
import 'TabBarPageSecond.dart';
import 'TabBarPageThree.dart';
import 'TabBarWidget.dart';

class TabBarBottomPageWidget extends StatefulWidget {
  @override
  _TabBarBottomPageWidgetState createState() => _TabBarBottomPageWidgetState();
}

class _TabBarBottomPageWidgetState extends State<TabBarBottomPageWidget>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = new ScrollController();

  final PageController topPageControl = new PageController();

  final List<String> tab = ["动态", "趋势", "我的"];

  _renderTab() {
    List<Widget> list = new List();
    for (int i = 0; i < tab.length; i++) {
      list.add(new FlatButton(
          onPressed: () {
            topPageControl.jumpTo(MediaQuery.of(context).size.width * i);
          },
          child: new Text(
            tab[i],
            maxLines: 1,
          )));
    }
    return list;
  }

  _renderPage() {
    return [
      new TabBarPageFirst(),
      new TabBarPageSecond(),
      new TabBarPageThree(),
    ];
  }

  @override
  void initState() {
    ///滑动监听
    _scrollController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new TabBarWidget(
        type: TabBarWidget.BOTTOM_TAB,

        ///渲染tab
        tabItems: _renderTab(),

        ///渲染页面
        tabViews: _renderPage(),
        topPageControl: topPageControl,
        backgroundColor: Colors.black45,
        indicatorColor: Colors.white,
        title: new Text("GSYGithubFlutter"));
  }

  @override
  bool get wantKeepAlive => true;
}
