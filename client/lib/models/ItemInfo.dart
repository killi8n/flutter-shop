import 'package:flutter/widgets.dart';

class ItemInfo {
  Image image;
  String title;
  String description;
  String price;
  List<String> detailContents;

  ItemInfo(this.image, this.title, this.description, this.price,
      this.detailContents);
}
