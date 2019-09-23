import 'package:flutter/widgets.dart';

class ItemInfo {
  int id;
  Image image;
  String title;
  String description;
  int price;
  List<String> detailContents;

  ItemInfo(this.id, this.image, this.title, this.description, this.price,
      this.detailContents);
}
