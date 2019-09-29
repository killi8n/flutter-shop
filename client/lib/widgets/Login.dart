import 'dart:convert';

import 'package:client/utils/API.dart';
import 'package:client/utils/Global.dart';
import 'package:client/widgets/LoadingWrapper.dart';
import 'package:client/widgets/MainWidget.dart';
import 'package:client/widgets/Register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void checkToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainWidget()));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> handleSignIn() async {
    try {
      if (formKey.currentState.validate() == false) {
        return;
      }

      setState(() {
        isLoading = true;
      });

      final res =
          await API.signIn(emailController.text, passwordController.text);
      setState(() {
        isLoading = false;
      });

      final token = res.token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      Global.items = [];
      Global.profile = null;

      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainWidget()));
    } on ServerApiException catch (e) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('로그인 실패\n${json.decode(e.response.body)['message']}')));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('에러\n${e.toString()}')));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: LoadingWrapper(
        isLoading: isLoading,
        child: SafeArea(
          child: Center(
              child: Form(
            key: formKey,
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
                  child: TextFormField(
                    controller: emailController,
                    decoration:
                        InputDecoration(hintText: 'Please enter an email'),
                    validator: (value) => (value.isEmpty)
                        ? '내용을 입력해주세요.'
                        : (value.indexOf('@') < 0) ? '정확한 이메일을 입력해주세요.' : null,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: TextFormField(
                    controller: passwordController,
                    decoration:
                        InputDecoration(hintText: 'Please enter a password'),
                    validator: (value) =>
                        (value.isEmpty) ? '내용을 입력해주세요.' : null,
                    obscureText: true,
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
                        // await Navigator.push(context,
                        //     MaterialPageRoute(builder: (ctx) => MainWidget()));
                        await handleSignIn();
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
            ),
          )),
        ),
      ),
    );
  }
}
