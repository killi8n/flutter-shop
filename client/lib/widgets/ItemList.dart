import 'package:client/models/ItemInfo.dart';
import 'package:client/widgets/ItemDetail.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/StringUtil.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<ItemInfo> itemInfos;

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

  void initItemInfos() {
    if (itemInfos != null) {
      return;
    }

    itemInfos = <ItemInfo>[
      ItemInfo(
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
      ),
      ItemInfo(
        Image.network(
            'https://mi6.rightinthebox.com/images/384x384/201704/pqf1493005948537.jpg'),
        '빨간 스웨터',
        '추운 겨울에도 식지 않는 정열의 레드',
        8000,
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
      ),
      ItemInfo(
        Image.network(
            'http://mblogthumb4.phinf.naver.net/20120901_223/dogtalk__1346433364891VL4Am_JPEG/0003-MMF0017_s.jpg?type=w2'),
        '말랑말랑 입마개',
        '부드럽고 엣지 있는 입마개',
        6000,
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
      ),
      ItemInfo(
        Image.network(
            'http://yogipet.co.kr/web/product/big/201706/yogi_main_500.jpg'),
        '소형견용 애견 화장실',
        '배변 교육이 쉬운 마법의 화장실',
        20000,
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
      ),
      ItemInfo(
        Image.network(
            'https://seoul-p-studio.bunjang.net/product/81561624_3_1520763876_w640.jpg'),
        '강아지 용 백팩',
        '이제 네 짐은 네가 지도록 하여라~',
        18000,
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
      ),
      ItemInfo(
        Image.network(
            'https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg'),
        '귀여운 강아지 신발',
        '소중한 아기의 발바닥을 보호합시다',
        12000,
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
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    initItemInfos();

    final widgets = itemInfos
        .map((itemInfo) => FlatButton(
              onPressed: () async {
                await Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => ItemDetail()));
              },
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                        height: 150.0,
                        margin: EdgeInsets.only(right: 20),
                        child: itemInfo.image),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          itemInfo.title,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          itemInfo.description,
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        Text(
                          '${StringUtil.makeCommaedString(itemInfo.price)}원',
                          style: TextStyle(fontSize: 15, color: Colors.orange),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
        .toList();

    return ListView(
      children: widgets,
    );
  }
}
