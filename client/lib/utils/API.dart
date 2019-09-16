import 'dart:convert';

import 'package:client/models/LoginResponse.dart';
import 'package:client/utils/Global.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<void> register(
      String email, String name, String address, String password) async {
    return await post('/api/customers', {
      'values': json.encode({
        'email': email,
        'name': name,
        'address': address,
        'password': password,
      })
    });
  }

  static Future<void> signIn(String email, String password) async {
    final res = await post('/api/login',
        {'type': 'CUSTOMER', 'loginId': email, 'password': password});

    return LoginResponse.fromJson(json.decode(res.body)['items'][0]);
  }

  static Future<http.Response> post(
      String path, Map<String, String> body) async {
    final res = await http.post(Global.localServerAddress + path, body: body);
    return requestTail(res);
  }

  static http.Response requestTail(http.Response res) {
    if (res.statusCode ~/ 100 == 2) {
      return res;
    }
    throw ServerApiException(res);
  }
}

class ServerApiException implements Exception {
  http.Response response;
  ServerApiException(this.response);
}
