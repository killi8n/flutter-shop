import 'dart:math';

import 'package:client/models/CartInfo.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/StringUtil.dart';
import 'package:flutter/services.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartInfo> cartInfos;
  final itemIdControllerMap = Map<int, TextEditingController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (final controller in itemIdControllerMap.values) {
      controller.dispose();
    }
    itemIdControllerMap.clear();
  }

  void initCartInfos() {
    if (cartInfos != null) {
      return;
    }

    cartInfos = <CartInfo>[
      CartInfo(
          0,
          Image.network(
              'http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg'),
          '뼈다귀 모양 베개',
          10000,
          1),
      CartInfo(
          1,
          Image.network(
              'https://mi6.rightinthebox.com/images/384x384/201704/pqf1493005948537.jpg'),
          '빨간 스웨터',
          8000,
          2),
      CartInfo(
          2,
          Image.network(
              'https://seoul-p-studio.bunjang.net/product/81561624_3_1520763876_w640.jpg'),
          '강아지 용 백팩',
          18000,
          3),
      CartInfo(
          3,
          Image.network(
              'https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg'),
          '귀여운 강아지 신발',
          12000,
          1),
    ];

    for (final info in cartInfos) {
      final controller = TextEditingController(text: '${info.count}');
      itemIdControllerMap[info.id] = controller;
      controller.addListener(() {
        setState(() {
          info.count = (controller.text == '') ? 0 : int.parse(controller.text);
        });
      });
    }
  }

  String computeTotalPrice() {
    var totalPrice = 0;
    for (final cartInfo in cartInfos) {
      final controller = itemIdControllerMap[cartInfo.id];
      final count = (controller.text == '') ? 0 : int.parse(controller.text);
      totalPrice += count * cartInfo.price;
    }
    return '${StringUtil.makeCommaedString(totalPrice)}원';
  }

  @override
  Widget build(BuildContext context) {
    initCartInfos();

    final cartList = cartInfos
        .map((info) => Row(
              children: <Widget>[
                Checkbox(
                  value: info.isChecked,
                  onChanged: (value) => setState(() => info.isChecked = value),
                  activeColor: Colors.pinkAccent,
                ),
                Container(
                  height: 70,
                  child: info.image,
                  margin: EdgeInsets.all(20),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        info.title,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text('${StringUtil.makeCommaedString(info.price)}원',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.orangeAccent)),
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text('개수'),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  height: 25,
                                  margin: EdgeInsets.only(right: 10),
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(Icons.add, size: 20),
                                    onPressed: () {
                                      final controller =
                                          itemIdControllerMap[info.id];
                                      final count = (controller.text == '')
                                          ? 0
                                          : int.parse(controller.text);
                                      controller.text =
                                          '${min(999, count + 1)}';
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                  child: TextField(
                                      controller: itemIdControllerMap[info.id],
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.all(2)),
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ]),
                                ),
                                Container(
                                    width: 25,
                                    height: 25,
                                    margin: EdgeInsets.only(left: 10),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      child: Icon(Icons.remove, size: 20),
                                      onPressed: () {
                                        final controller =
                                            itemIdControllerMap[info.id];
                                        final count = (controller.text == '')
                                            ? 0
                                            : int.parse(controller.text);
                                        controller.text =
                                            '${max(0, count - 1)}';
                                      },
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text('금액'),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Text('${StringUtil.makeCommaedString(info.price)}원',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.green))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))
        .toList();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: cartList,
              ),
            ),
          ),
          Container(
            height: 3.0,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black54))),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('총 가격:'),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      '${computeTotalPrice()}',
                      style: TextStyle(color: Colors.orangeAccent),
                    )
                  ],
                ),
                FractionallySizedBox(
                  child: FlatButton(
                    child: Text('구매하기'),
                    onPressed: () {},
                    color: Colors.pinkAccent,
                    textColor: Colors.white,
                  ),
                  widthFactor: 1.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
