import 'package:flutter/widgets.dart';

class ItemInfo {
  Image image;
  String title;
  String description;
  int price;
  List<String> detailContents;

  ItemInfo(this.image, this.title, this.description, this.price,
      this.detailContents);
}
