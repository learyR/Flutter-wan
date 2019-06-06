import 'package:flutter/material.dart';

///类似于popuWind 可固定位置弹窗的组件
class PopupWindowComponent extends StatelessWidget {
  Widget child;
  double verticalOffset;
  bool isPreferBelow;

  ///自定义内容
  List<Widget> items;

  ///默认删除点击事件
  Function onDefaultDelete;

  ///默认收藏点击事件
  Function onDefaultCollection;

  ///默认转发点击事件
  Function onDefaultForward;

  PopupWindowComponent(
      {@required this.child,
      this.verticalOffset,
      this.isPreferBelow,
      this.items,
      this.onDefaultDelete,
      this.onDefaultCollection,
      this.onDefaultForward});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onLongPress: () => Navigator.push(
            context,
            CustomRoute(
              child: _buildContainer(context),
            ),
          ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Material(
      color: Color(0x5f000000),
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            _buildChild(context, verticalOffset, isPreferBelow, items),
          ],
        ),
        onTap: () {
          //点击空白处
          Navigator.of(context).pop();
        },
      ),
    );
  }

  ///弹窗 widget
  Widget _buildChild(BuildContext context, double verOffset, bool isPrefer,
      List<Widget> items) {
    final RenderBox box = context.findRenderObject();
    final Offset target = box.localToGlobal(box.size.topCenter(Offset.zero));
    return CustomSingleChildLayout(
      delegate: _PositionDelegate(
        target: target,
        verticalOffset: verOffset ?? 0.0,
        preferBelow: isPrefer ?? false,
      ),
      child: GestureDetector(
        child: Container(
          width: (items == null || items.isEmpty)
              ? 171.0
              : ((items.length) / 2) * 57.0,
          height: 45.0,
          child: Column(
            children: <Widget>[
              Container(
                height: 36.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xe6060606),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: items ??
                      <Widget>[
                        GestureDetector(
                          child: Text(
                            '转发',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: onDefaultForward,
                          onTapCancel: () => Navigator.of(context).pop(),
                        ),
                        Container(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: onDefaultCollection,
                          child:
                              Text('收藏', style: TextStyle(color: Colors.white)),
                        ),
                        Container(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: onDefaultDelete,
                          child:
                              Text('删除', style: TextStyle(color: Colors.white)),
                        )
                      ],
                ),
              ),
              Image.asset('assets/images/icon_black_arrow_down.png')
            ],
          ),
        ),
      ),
    );
  }
}

///参考tooltip的控件绑定
class _PositionDelegate extends SingleChildLayoutDelegate {
  _PositionDelegate({
    @required this.target,
    @required this.verticalOffset,
    @required this.preferBelow,
  })  : assert(target != null),
        assert(verticalOffset != null),
        assert(preferBelow != null);

  final Offset target;

  final double verticalOffset;

  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(_PositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}

///参考popMenu
class CustomRoute extends PopupRoute {
  Widget child;

  CustomRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);
}
