/** widget 状态管理 */

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
            Text('Widget管理自身状态,点击下面'),
            BoxA(),
          ],
        ),
      ),
    );
  }
}

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
              fontSize: 32,
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
