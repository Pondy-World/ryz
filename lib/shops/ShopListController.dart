import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ryz/controllers/baseValues.dart';

class ShopListController {
  String newStr = "";
  Auth auth = new Auth();

  var shopListResponse = {};

  void stringMethod({required String valA}) {
    this.newStr = valA;
  }

  Future<Map> fetchAllShops() async {
    var url = Uri.parse(baseurl + 'Shops/shoplist.php');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));

    var response = await http.get(
      url,
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': basicAuth},
    );

    var jsonBody = response.body;
    shopListResponse = jsonDecode(jsonBody);
    return shopListResponse;
  }

  Future<String> fetchShopsCat(String headID) async {
    var url = Uri.parse(baseurl + 'Shops/shoplistallcat.php?catid=$headID');
    print(url);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode((auth.authName + ':' + auth.authPass)));

    var response = await http.get(
      url,
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': basicAuth},
    );

    var jsonBody = response.body;
    shopListResponse = jsonDecode(jsonBody);
    print(jsonBody);
    print(shopListResponse["data"]);

    print(shopListResponse["data"][0]["id"]);

    var status = "oString();";

    return status;
  }
}
