import 'package:client/models/ItemResponse.dart';

class CustomerHasItemResponse {
  int id;
  String title;
  String description;
  int price;
  String image;
  int count;
  List<String> detailContents;
  String createAt;
  String updateAt;

  // int id;
  // int customerId;
  // int itemId;
  // int count;
  // String status;
  // String paidDtm;
  // ItemResponse item;

  CustomerHasItemResponse(
      this.id,
      this.title,
      this.description,
      this.price,
      this.image,
      this.count,
      this.detailContents,
      this.createAt,
      this.updateAt);
  factory CustomerHasItemResponse.fromJson(Map<String, dynamic> json) {
    return CustomerHasItemResponse(
      json['id'],
      json['title'],
      json['description'],
      json['price'],
      json['image'],
      json['count'],
      json['detailContent'],
      json['createAt'],
      json['updateAt'],
    );
  }
}
