import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/utils/Global.dart';
import 'package:client/models/LoginResponse.dart';
import 'package:client/models/ItemResponse.dart';

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

  static Future<List<ItemResponse>> fetchItems(
      Map<String, dynamic> query) async {
    final res = await get('/api/items', {'options': json.encode(query)});
    return json
        .decode(res.body)['items']
        .map<ItemResponse>((item) => ItemResponse.fromJson(item))
        .toList();
  }

  static Future<http.Response> get(
      String path, Map<String, String> query) async {
    final uri = Uri(queryParameters: query);
    final res =
        await http.get(Global.localServerAddress + path + '?' + uri.query);
    return requestTail(res);
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
