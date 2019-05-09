import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  static const int BOTTOM_TAB = 1;
  static const int TOP_TAB = 2;

  final int type;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final TarWidgetControl tarWidgetControl;

  final PageController topPageControl;

  TabBarWidget(
      {Key key,
      this.type,
      this.tabItems,
      this.tabViews,
      this.backgroundColor,
      this.indicatorColor,
      this.title,
      this.drawer,
      this.floatingActionButton,
      this.tarWidgetControl,
      this.topPageControl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _TabBarState(type, tabItems, tabViews, backgroundColor,
        indicatorColor, title, drawer, floatingActionButton, topPageControl);
  }
}

class _TabBarState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = new ScrollController();

  final int _type;

  final List<Widget> _tabItems;

  final List<Widget> _tabViews;

  final Color _backgroundColor;

  final Color _indicatorColor;

  final Widget _title;

  final Widget _drawer;

  final Widget _floatingActionButton;

  final PageController _pageController;

  _TabBarState(
      this._type,
      this._tabItems,
      this._tabViews,
      this._backgroundColor,
      this._indicatorColor,
      this._title,
      this._drawer,
      this._floatingActionButton,
      this._pageController)
      : super();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabItems.length, vsync: this);
    //加载更多
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this._type == TabBarWidget.TOP_TAB) {
      return new Scaffold(
        ///抽屉
        drawer: _drawer,

        ///悬浮按钮
        floatingActionButton: _floatingActionButton,

        ///标题
        appBar: new AppBar(
          backgroundColor: _backgroundColor,
          title: _title,

          ///tabBar控件
          bottom: new TabBar(
            ///每一个tabItem，是一个List
            tabs: _tabItems,

            ///顶部时可滑动
            isScrollable: true,

            ///必须有的控制器
            controller: _tabController,
            indicatorColor: _indicatorColor,
          ),
        ),

        ///页面主体
        body: new PageView(
          controller: _pageController,
          children: _tabViews,
          onPageChanged: (index) {
            _tabController.animateTo(index);
          },
        ),
      );
    }

    ///底部
    return new Scaffold(
      drawer: _drawer,
      floatingActionButton: _floatingActionButton,
      appBar: new AppBar(
        backgroundColor: _backgroundColor,
        title: _title,
      ),
      body: new PageView(
        controller: _pageController,
        children: _tabViews,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
      ),

      ///底部导航栏
      bottomNavigationBar: new Material(
        color: _backgroundColor,
        child: new TabBar(
          tabs: _tabItems,
          controller: _tabController,
          indicatorColor: _indicatorColor,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
