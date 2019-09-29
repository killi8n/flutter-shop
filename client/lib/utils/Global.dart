import 'package:client/models/CustomerHasItemResponse.dart';
import 'package:client/models/ItemResponse.dart';
import 'package:client/models/ProfileResponse.dart';

class Global {
  static double statusBarHeight = 0.0;
  static double appBarHeight = 0.0;
  static String localServerAddress = 'http://127.0.0.1:4000';

  static List<ItemResponse> items = [];
  static List<CustomerHasItemResponse> prevCustomerHasItems = [];
  static ProfileResponse profile = null;
}
