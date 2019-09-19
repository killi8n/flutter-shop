import 'package:client/models/ItemResponse.dart';

class CustomerHasItemResponse {
  int id;
  int customerId;
  int itemId;
  int count;
  String status;
  String paidDtm;
  ItemResponse item;

  CustomerHasItemResponse(this.id, this.customerId, this.itemId, this.count,
      this.status, this.paidDtm, this.item);
  factory CustomerHasItemResponse.fromJson(Map<String, dynamic> json) {
    return CustomerHasItemResponse(
      json['id'],
      json['customerId'],
      json['itemId'],
      json['count'],
      json['status'],
      json['paidDtm'],
      ItemResponse.fromJson(json['item']),
    );
  }
}
