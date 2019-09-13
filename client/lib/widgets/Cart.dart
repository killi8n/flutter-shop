import 'package:client/models/CartInfo.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/StringUtil.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartInfo> cartInfos = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                                Icon(Icons.add),
                                SizedBox(width: 7.0),
                                SizedBox(
                                  width: 50.0,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(2)),
                                  ),
                                ),
                                SizedBox(width: 7.0),
                                Icon(Icons.remove)
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
                      '92,000원',
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
