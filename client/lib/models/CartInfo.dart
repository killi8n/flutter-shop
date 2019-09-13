import 'package:flutter/material.dart';

class CartInfo {
  int id;
  Image image;
  String title;
  int price;
  int count;
  bool isChecked = true;

  CartInfo(this.id, this.image, this.title, this.price, this.count);
}
