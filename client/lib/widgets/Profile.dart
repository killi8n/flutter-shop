import 'dart:convert';

import 'package:client/utils/API.dart';
import 'package:client/utils/Global.dart';
import 'package:client/widgets/LoadingWrapper.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController phoneController;
  TextEditingController emailContronller;
  TextEditingController addressController;

  bool isLoading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    phoneController = TextEditingController(text: '');
    emailContronller = TextEditingController(text: '');
    addressController = TextEditingController(text: '');
    if (Global.profile == null) {
      getProfile();
    } else {
      phoneController.text = Global.profile.phoneNumber;
      emailContronller.text = Global.profile.email;
      addressController.text = Global.profile.address;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    phoneController.dispose();
    emailContronller.dispose();
    addressController.dispose();
  }

  void getProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await API.fetchProfile({});

      phoneController.text = res.phoneNumber;
      emailContronller.text = res.email;
      addressController.text = res.address;

      Global.profile = res;

      setState(() {
        isLoading = false;
      });
    } on ServerApiException catch (e) {
      final msg = json.decode(e.response.body)['message'];
      setState(() {
        isLoading = false;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('에러${msg}'),
      ));
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      key: scaffoldKey,
      body: LoadingWrapper(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: mq.size.height -
                    Global.statusBarHeight -
                    Global.appBarHeight),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: ClipOval(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Image(
                            image: NetworkImage(
                                "https://pbs.twimg.com/profile_images/1603440593/AgDLph81_400x400")),
                      ),
                    ),
                  ),
                  Container(height: 15.0),
                  Text(
                    '쇼핑왕 보거스',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Container(height: 5.0),
                  Text(
                    'VIP customer',
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
                  ),
                  Container(height: 30.0),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        Container(width: 15.0),
                        Expanded(
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                hintText: 'Please enter a phone number'),
                            validator: (value) =>
                                (value.isEmpty) ? '휴대전화번호를 입력해주세요' : null,
                          ),
                        )
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.email),
                        Container(width: 15.0),
                        Expanded(
                          child: TextFormField(
                            controller: emailContronller,
                            decoration: InputDecoration(
                                hintText: 'Please enter an email address'),
                            validator: (value) =>
                                (value.isEmpty) ? '이메일 주소를 입력해주세요' : null,
                          ),
                        )
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.flag),
                        Container(width: 15.0),
                        Expanded(
                          child: TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                                hintText: 'Please enter an address'),
                            validator: (value) =>
                                (value.isEmpty) ? '주소를 입력해주세요.' : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
