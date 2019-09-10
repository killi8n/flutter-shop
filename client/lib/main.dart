import 'package:client/widgets/MainWidget.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Shop',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            primaryTextTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
            accentColor: Colors.white),
        initialRoute: '/',
        routes: {'/': (ctx) => Login(), '/main': (ctx) => MainWidget()});
  }
}
