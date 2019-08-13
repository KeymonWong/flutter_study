import 'package:flutter/material.dart';


Route<dynamic> _onRouter(RouteSettings settings) {
  if (settings.name == '/FirstPage') {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        String routeName = settings.name;
        //如果访问的路由页面需要登录，但当前未登录，则直接返回登录页路由
        //引导用户登录；其他情况则正常打开路由
        // Navigator.of(context).pushNamed(routeName);
      },
    );
  }
  //The other paths we support are in the routes table. 其他的路由使用注册的路由表里的
  return null;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      
      initialRoute: "/", //名为 "/" 的路由作为 App 的初始路由页面，即首页
      //注册路由表
      routes: {
        '/': (BuildContext ctx) => MyHomePage(title: 'Flutter Demo Home Page'), //注册首页路由
        '/FirstPage': (BuildContext ctx) => FirstPage(),
        '/SecondPage': (BuildContext ctx) => SecondPage(text: ModalRoute.of(context).settings.arguments),
      },
      //注意onGenerateRoute只会对命名路由生效
      //它在打开命名路由时可能会被调用，之所以说可能，是因为当调用Navigator.pushNamed(...)打开命名路由时，
      //如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；
      //如果路由表中没有注册，才会调用onGenerateRoute来生成路由。
      //可以通过onGenerateRoute做一些全局的路由跳转前置处理逻辑。
      //建议读者最好统一使用命名路由的管理方式
      onGenerateRoute: _onRouter,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("打开新路由页面"),
              textColor: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, '/FirstPage');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute( 
                //     builder: (context) {
                //       return FirstPage();
                //     },
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage extends StatelessWidget {
  SecondPage({
    Key key,

    @required 
    this.text, // 接收一个 text 参数
  }) : super(key: key);

  final String text;
  
  @override
  Widget build(BuildContext context) {
    print("push传过来的值为(当前SecondPage)：$text");

    return Scaffold(
      appBar: AppBar(
        title: Text("SecondPage"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                //pop 时返回的值
                onPressed: () => Navigator.pop(context, "pop 返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FirstPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                //打开 SecondPage ，并异步等待返回结果
                var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    //第一个页面向第二个页面传值，类似 iOS push、pop 的传值
                    builder: (context) => SecondPage(text: "FirstPage->SecondPage push传过来的值"),
                  ),
                );

                //pop时 获取返回的值
                print("pop返回的值为(当前FirstPage)：$res");
              },
              child: Text("打开提示页面"),
            ),
          ],
        ),
      ),
    );
  }
}
