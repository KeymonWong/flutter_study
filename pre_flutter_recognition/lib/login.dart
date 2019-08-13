import 'package:flutter/material.dart';

class Login extends StatelessWidget {
   const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: new EdgeInsets.all(20),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Text('这是登录页面'),
            ],
          ),
        ),
      ),
    );
  }
}
