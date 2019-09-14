import 'package:client/widgets/MainWidget.dart';
import 'package:client/widgets/Register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Flutter Shop', style: TextStyle(fontSize: 40.0)),
                Container(width: 10.0),
                Icon(Icons.pets)
              ],
            ),
            Container(height: 30.0),
            FractionallySizedBox(
              widthFactor: 0.6,
              child: TextField(
                decoration: InputDecoration(hintText: 'Please enter an email'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.6,
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Please enter a password'),
              ),
            ),
            Container(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    // await Navigator.pushNamed(context, '/main');
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => MainWidget()));
                  },
                  child: Text('sign in'),
                ),
                FlatButton(
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => Register()));
                  },
                  child: Text('sign up'),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
