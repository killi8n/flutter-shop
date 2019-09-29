class ProfileResponse {
  int id;
  String email;
  String name;
  String address;
  String phoneNumber;
  String createdAt;
  String updatedAt;

  ProfileResponse(this.id, this.email, this.name, this.address,
      this.phoneNumber, this.createdAt, this.updatedAt);
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
        json['id'],
        json['email'],
        json['name'],
        json['address'],
        json['phoneNumber'],
        json['createdAt'],
        json['updatedAt']);
  }
}
