import 'dart:convert';
import 'package:client/models/CartInfo.dart';
import 'package:client/models/CustomerHasItemResponse.dart';
import 'package:client/models/ProfileResponse.dart';
import 'package:http/http.dart' as http;
import 'package:client/utils/Global.dart';
import 'package:client/models/LoginResponse.dart';
import 'package:client/models/ItemResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  static Future<void> register(
      String email, String name, String address, String password) async {
    return await post(
        '/api/customers',
        {
          'values': json.encode({
            'email': email,
            'name': name,
            'address': address,
            'password': password,
          }),
        },
        null);
  }

  static Future<LoginResponse> signIn(String email, String password) async {
    final res = await post('/api/login',
        {'type': 'CUSTOMER', 'loginId': email, 'password': password}, null);

    return LoginResponse.fromJson(json.decode(res.body)['items'][0]);
  }

  static Future<List<ItemResponse>> fetchItems(
      Map<String, dynamic> query) async {
    final res = await get('/api/items', {'options': json.encode(query)}, null);
    return json
        .decode(res.body)['items']
        .map<ItemResponse>((item) => ItemResponse.fromJson(item))
        .toList();
  }

  static Future<List<CustomerHasItemResponse>> fetchCustomerItem(
      Map<String, dynamic> query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await get('/api/custom-has-items',
        {'options': json.encode(query)}, {'authorization': token});

    return json
        .decode(res.body)['items']
        .map<CustomerHasItemResponse>(
            (item) => CustomerHasItemResponse.fromJson(item))
        .toList();
  }

  static Future<ProfileResponse> fetchProfile(
      Map<String, dynamic> query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await get('/api/customers', {'options': json.encode(query)},
        {'authorization': token});
    return ProfileResponse.fromJson(json.decode(res.body)['items'][0]);
  }

  static Future<void> updateProfile(
      String email, String address, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return await put('/api/customers', {
      'values': json.encode(
          {'email': email, 'address': address, 'phoneNumber': phoneNumber})
    }, {
      'authorization': token
    });
  }

  static Future<void> createCart(int itemId, int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return await post('/api/custom-has-items', {
      'values': json.encode({'itemId': itemId, 'count': count})
    }, {
      'authorization': token
    });
  }

  static Future<void> updateCart(int itemId, int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return await put('/api/cusom-has-items/${itemId}', {
      'values': json.encode({'count': count})
    }, {
      'authorization': token
    });
  }

  static Future<http.Response> get(String path, Map<String, String> query,
      Map<String, String> headers) async {
    final uri = Uri(queryParameters: query);
    final res = await http.get(
        Global.localServerAddress + path + '?' + uri.query,
        headers: headers != null ? headers : null);
    return requestTail(res);
  }

  static Future<http.Response> post(String path, Map<String, String> body,
      Map<String, String> headers) async {
    final res = await http.post(Global.localServerAddress + path,
        body: body, headers: headers);

    return requestTail(res);
  }

  static Future<http.Response> put(String path, Map<String, String> body,
      Map<String, String> headers) async {
    final res = await http.put(Global.localServerAddress + path,
        body: body, headers: headers);
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
