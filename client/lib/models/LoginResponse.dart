class LoginResponse {
  int id;
  String role;
  String token;

  LoginResponse(this.id, this.role, this.token);
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(json['id'], json['role'], json['token']);
  }
}
