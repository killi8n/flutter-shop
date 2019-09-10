import 'package:client/utils/Global.dart';
import 'package:client/widgets/Profile.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.shopping_basket),
              text: 'Item List',
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
              text: 'Cart',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'Profile',
            )
          ],
        ),
      ),
    );

    final mq = MediaQuery.of(context);
    Global.statusBarHeight = mq.padding.top;
    Global.appBarHeight = appBar.preferredSize.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBar,
        body: TabBarView(
          children: <Widget>[
            Text('Item List', style: TextStyle(fontSize: 15.0)),
            Text('Cart', style: TextStyle(fontSize: 15.0)),
            Profile()
          ],
        ),
      ),
    );
  }
}
