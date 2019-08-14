import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);

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
              RandomWordsWidget(), //自定义Widget
            ],
          ),
        ),
      ),
    );
  }
}

//自定义Widget
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    debugPrint('$wordPair');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text('随机字符：' + wordPair.toString()),
    );
  }
}
