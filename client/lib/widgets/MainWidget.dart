import 'package:client/utils/Global.dart';
import 'package:client/widgets/Cart.dart';
import 'package:client/widgets/ItemList.dart';
import 'package:client/widgets/Profile.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: TabBar(
          controller: tabController,
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

    return Scaffold(
      appBar: appBar,
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          ItemList(
            onAddToCart: () {
              tabController.animateTo(1);
            },
          ),
          Cart(),
          Profile()
        ],
      ),
    );
  }
}
