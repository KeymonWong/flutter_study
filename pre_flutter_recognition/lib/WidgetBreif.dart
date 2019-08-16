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

///注意：在继承StatefulWidget重写其方法时，对于包含@mustCallSuper标注的父类方法，
///都要在子类方法中先调用父类方法。
class _CounterStatefulWidgetState extends State<CounterStatefulWidget> {
  int _counter;

  /****** State生命周期 ******/

  ///当Widget第一次插入到Widget树时会被调用，对于每一个State对象，只会调用一次该回调，
  ///通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等
  @override
  void initState() {
    super.initState();
    _counter = widget.initVal;
    print('initState');
  }

  ///主要是用于构建Widget子树的，会在如下场景被调用：
  ///1.在调用initState()之后。
  ///2.在调用didUpdateWidget()之后。
  ///3.在调用setState()之后。
  ///4.在调用didChangeDependencies()之后。
  ///5.在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
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

  ///在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中同一位置的新旧节点，
  ///然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调。正如之前所述，
  ///Widget.canUpdate会在新旧widget的key和runtimeType同时相等时会返回true，
  ///也就是说在在新旧widget的key和runtimeType同时相等时didUpdateWidget()就会被调用。
  @override
  void didUpdateWidget(CounterStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  ///当State对象从树中被移除时，会调用此回调。如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  ///当State对象从树中被永久移除时调用；通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }
  
  ///专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
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
