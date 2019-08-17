/** widget 状态管理 */
///管理状态最常见的方法：
///1.Widget管理自己的状态；
///2.Widget管理子Widget状态；
///3.混合管理（父Widget和子Widget都管理状态）。

///在Widget内部管理状态封装性会好一些，而在父Widget中管理会比较灵活。如果不确定到底该怎么管理状态，
///那么推荐的首选是在父widget中管理（灵活会显得更重要一些）。
///管理方式选择：
///1.如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父Widget管理
///2.如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由Widget本身来管理
///3.如果某一个状态是不同Widget共享的则最好由它们共同的父Widget管理

import 'package:flutter/material.dart';

class WidgetStateManager extends StatelessWidget {
  const WidgetStateManager({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget状态管理'),
      ),
      body: Container(
        color: Colors.cyan[100],
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Text('\n'),
            Text('Widget管理自身状态,点击下面'),
            BoxA(),
            Text('\n'),
            Text(
              
              '父Widget管理子Widget的状态,点击下面'
            ),
            ParentWidget(),
          ],
        ),
      ),
    );
  }
}

// BoxA 管理自身状态.
//------------------------- BoxA -----------------------------
class BoxA extends StatefulWidget {
  BoxA({Key key}) : super(key: key);

  _BoxAState createState() => _BoxAState();
}

class _BoxAState extends State<BoxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey,
        ),
      ),
    );
  }
}

// ParentWidget 为 BoxB 管理状态.
//------------------------ ParentWidget --------------------------
class ParentWidget extends StatefulWidget {
  ParentWidget({Key key}) : super(key: key);

  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;
  
  void _handleBoxChanged(bool newVal) {
    setState(() {
      _active = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new BoxB(
        active: _active,
        onChanged: _handleBoxChanged,
      ),
    );
  }
}

class BoxB extends StatelessWidget {
  const BoxB({
    Key key,

    this.active: false,

    @required
    this.onChanged,

  }) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged; //回调方法，将状态回调给父 widget

  void _handleTap() => onChanged(!active);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(
              fontSize: 24,
              color: Colors.black,
            )
          ),
        ),
        height: 150,
        width: 150,
        decoration: new BoxDecoration(
          color: active ? Colors.lightBlue[300] : Colors.grey[600],
        ),
      ),
    );
  }
}