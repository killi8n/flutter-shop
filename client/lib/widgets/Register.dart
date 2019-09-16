import 'dart:convert';

import 'package:client/utils/Global.dart';
import 'package:client/widgets/LoadingWrapper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:client/utils/API.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  bool isSubmittable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
  }

  Future<void> register() async {
    try {
      if (formKey.currentState.validate() == false) {
        return;
      }

      this.setState(() {
        isSubmittable = false;
      });

      await API.register(emailController.text, nameController.text,
          addressController.text, passwordController.text);

      Navigator.pop(context, null);
    } on ServerApiException catch (e) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
              '요청이 실패했습니다.\n${json.decode(json.decode(e.response.body))['message']}')));
      this.setState(() {
        isSubmittable = true;
      });
    } catch (e) {
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('에러.\n${e.toString()}')));
      this.setState(() {
        isSubmittable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputList = [
      {
        'title': '이메일',
        'controller': emailController,
        'validator': (value) => (value.isEmpty)
            ? '내용을 입력 해 주세요'
            : (value.indexOf('@') > 0) ? null : '올바른 이메일 형식이 아닙니다.'
      },
      {
        'title': '비밀번호',
        'controller': passwordController,
        'validator': (value) => (value.isEmpty) ? '내용을 입력 해 주세요' : null
      },
      {
        'title': '이름',
        'controller': nameController,
        'validator': (value) => (value.isEmpty) ? '내용을 입력 해 주세요' : null,
      },
      {
        'title': '주소',
        'controller': addressController,
        'validator': (value) => (value.isEmpty) ? '내용을 입력 해 주세요' : null
      }
    ];

    final appBar = AppBar(
      title: Text('회원 가입'),
    );

    final inputWithTitles = inputList
        .map((input) => Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 60, child: Text(input['title'])),
                  Expanded(
                    child: TextFormField(
                      obscureText: input['title'] == '비밀번호' ? true : false,
                      controller: input['controller'],
                      validator: input['validator'],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(9)),
                    ),
                  )
                ],
              ),
            ))
        .toList();

    final form = Form(
      key: formKey,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: inputWithTitles,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: FlatButton(
                    child: Text(isSubmittable ? '회원 가입 완료' : '요청중'),
                    color: Colors.pink,
                    textColor: Colors.white,
                    onPressed: () async {
                      await register();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    return Scaffold(
        appBar: appBar,
        body: LoadingWrapper(
          child: form,
          isLoading: !isSubmittable,
        ),
        key: scaffoldKey);
  }
}
