import 'dart:convert';
import 'dart:math';

import 'package:client/models/CartInfo.dart';
import 'package:client/utils/API.dart';
import 'package:client/utils/Global.dart';
import 'package:client/widgets/LoadingWrapper.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/StringUtil.dart';
import 'package:flutter/services.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isLoading = false;
  List<CartInfo> cartInfos;
  final itemIdControllerMap = Map<int, TextEditingController>();

//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cartInfos = [];
    cartInfos = Global.prevCustomerHasItems
        .map((item) => CartInfo(item.id, Image.network(item.image), item.title,
            item.price, item.count))
        .toList();
    fetchDataAndRefresh();
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

  void fetchDataAndRefresh() async {
    try {
      setState(() {
        isLoading = true;
      });

      final customerHasItems = await API.fetchCustomerItem({
        'where': {'status': 'CART'},
        'include': [
          {'association': 'item'}
        ]
      });

      await Future.delayed(Duration(seconds: 1));
      Global.prevCustomerHasItems = customerHasItems;

      if (!mounted) {
        return;
      }

      final newItemsInfos = customerHasItems
          .map((item) => CartInfo(item.id, Image.network(item.image),
              item.title, item.price, item.count))
          .toList();

      setState(() {
        refreshItemIdControllerMap(newItemsInfos);
        isLoading = false;
        cartInfos = newItemsInfos;
      });
    } on ServerApiException catch (e) {
      final msg = json.decode(e.response.body)['message'];
      print(msg);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void refreshItemIdControllerMap(List<CartInfo> cartInfos) {
    for (final info in cartInfos) {
      if (itemIdControllerMap.containsKey(info.id)) {
        itemIdControllerMap[info.id].text = '${info.count}';

        continue;
      }

      final controller = TextEditingController(text: '${info.count}');
      controller.addListener(() {
        setState(() {
          info.count = (controller.text == '') ? 0 : int.parse(controller.text);
        });
      });
      itemIdControllerMap[info.id] = controller;
    }
  }

  // String computeTotalPrice() {
  //   var totalPrice = 0;
  //   for (final cartInfo in cartInfos) {
  //     final controller = itemIdControllerMap[cartInfo.id];
  //     final count = (controller.text == '') ? 0 : int.parse(controller.text);
  //     totalPrice += count * cartInfo.price;
  //   }
  //   return '${StringUtil.makeCommaedString(totalPrice)}원';
  // }

  @override
  Widget build(BuildContext context) {
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

    return LoadingWrapper(
      isLoading: isLoading,
      child: Scaffold(
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
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('총 가격:'),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        '${StringUtil.makeCommaedString(cartInfos.where((cart) => cart.isChecked).map((cart) => cart.price * cart.count).fold(0, (a, b) => a + b))}원',
                        style: TextStyle(color: Colors.orangeAccent),
                      )
                    ],
                  ),
                  FractionallySizedBox(
                    child: FlatButton(
                      child: Text('구매하기'),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        for (final cart in cartInfos) {
                          if (!cart.isChecked) {
                            continue;
                          }

                          final countText = itemIdControllerMap[cart.id].text;
                          if (countText == '') {
                            continue;
                          } else {
                            await API.updateCart(cart.id,
                                (countText == '') ? 0 : int.parse(countText));
                          }
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
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
      ),
    );
  }
}
