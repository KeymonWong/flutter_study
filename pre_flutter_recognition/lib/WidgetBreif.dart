import 'package:flutter/material.dart'; //安卓默认视觉效果

class WidgetBreif extends StatelessWidget {
  const WidgetBreif({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WidgetBreif'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('widget 简介'),
              EchoStatelessWidget(
                text: '无状态 echo',
                backgroundColor: Colors.cyan,
              ),
              CounterStatefulWidget(initVal: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class EchoStatelessWidget extends StatelessWidget {
  const EchoStatelessWidget({
    Key key,
    @required this.text,
    this.backgroundColor: Colors.blueGrey,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

class CounterStatefulWidget extends StatefulWidget {
  const CounterStatefulWidget({
    Key key,
    this.initVal: 0,
  }) : super(key: key);

  final int initVal;

  _CounterStatefulWidgetState createState() =>
      new _CounterStatefulWidgetState();
}

class _CounterStatefulWidgetState extends State<CounterStatefulWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initVal;
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Center(
      child: Row(
        children: <Widget>[
          Text('有状态 widget 按钮点击计数器：'),
          FlatButton(
            child: Text('$_counter'),
            textColor: Colors.green.shade800,
            color: Colors.pink[100],
            onPressed: () => setState(() => ++_counter),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(CounterStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}
