import 'package:client/models/ItemInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/utils/StringUtil.dart';

enum ItemDetailResult { BACK, ADD_TO_CART }

class ItemDetail extends StatefulWidget {
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  ItemInfo itemInfo;
  final countController = TextEditingController(text: '1');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countController.dispose();
  }

  void initItemInfo() {
    if (itemInfo != null) {
      return;
    }

    itemInfo = ItemInfo(
      Image.network(
          'http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg'),
      '뼈다귀 모양 베개',
      '우리 귀여운 강아지에게 꿀잠을!!',
      10000,
      <String>[
        '아이에게 꿀잠을 선사할 수 있는 베개입니다.',
        '뼈다귀 모양이므로 강아지에게 뼈다귀를 뜯는 꿈을 꿀 수 있도록 합니다.',
        '가나다라 마바사 아자차카 타파하',
        '',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
      ],
    );
  }

  String computeTotalPrice() {
    final count =
        (countController.text == '') ? 0 : int.parse(countController.text);
    return StringUtil.makeCommaedString(itemInfo.price * count);
  }

  @override
  Widget build(BuildContext context) {
    initItemInfo();

    return Scaffold(
      appBar: AppBar(title: Text('상품 상세')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(30),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: itemInfo.image,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            itemInfo.title,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            itemInfo.description,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.black54),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '${StringUtil.makeCommaedString(itemInfo.price)}원',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.orange),
                          ),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: itemInfo.detailContents
                                  .map<Widget>((content) {
                                return Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(content,
                                      style: TextStyle(fontSize: 15.0)),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          Container(
            height: 10.0,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black54))),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 60.0,
                  child: TextField(
                    controller: countController,
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(9)),
                  ),
                ),
                SizedBox(width: 5.0),
                Text('개', style: TextStyle(fontSize: 16)),
                Expanded(
                  child: SizedBox(),
                ),
                Text('${computeTotalPrice()}원',
                    style: TextStyle(fontSize: 18, color: Colors.orange))
              ],
            ),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(30, 5, 30, 8),
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text('장바구니에 넣기', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.pop(context, ItemDetailResult.ADD_TO_CART);
                },
              ))
        ],
      ),
    );
  }
}
