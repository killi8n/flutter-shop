class ItemResponse {
  int id;
  String title;
  String description;
  int price;
  String image;
  String detailContents;

  ItemResponse(this.id, this.title, this.description, this.price, this.image,
      this.detailContents);
  factory ItemResponse.fromJson(Map<String, dynamic> json) {
    return ItemResponse(
      json['id'],
      json['title'],
      json['description'],
      json['price'],
      json['image'],
      json['detailContents'],
    );
  }
}
